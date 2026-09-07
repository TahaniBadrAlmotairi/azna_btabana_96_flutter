import OpenAI from "openai";
import Busboy from "busboy";

const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

export const config = {
  api: {
    bodyParser: false,
  },
};

// ============================================================
// Prompt
// ============================================================

function getPrompt(style) {
  const base = `
Edit the uploaded person's photo into a premium Saudi National Day 96
crystal/rhinestone fashion style.

CRITICAL REQUIREMENTS:

IDENTITY:
- Preserve the person's identity exactly.
- Keep the face completely natural and photorealistic.
- Do NOT crystallize the face.
- Do NOT modify facial features.
- Do NOT change eyes, eyebrows, nose, mouth, jawline or skin.
- Preserve the person's natural expression.
- Preserve body shape, pose and proportions.

BACKGROUND:
- Keep the original background natural and realistic.
- Do NOT crystallize the background.
- Do NOT replace the background unless absolutely necessary.

CRYSTAL TRANSFORMATION:
Focus the crystal/rhinestone transformation mainly on:
- clothing
- fabric
- accessories
- jewelry
- decorative elements

The crystals must look like premium real glass rhinestones.
Use realistic reflections, highlights, sparkle and lighting.

IMPORTANT:
The result must still look like a real professional photograph.
Do NOT make it look like a cartoon, illustration, fantasy character,
3D render or completely artificial image.

Saudi National Day 96 aesthetic:
- elegant Saudi green accents
- luxurious crystal details
- refined Saudi national feeling
- premium editorial photography
`;

  const styles = {
    "خفيفة": `
Apply a subtle and elegant amount of crystal.

Keep most of the clothing realistic.
Add small premium rhinestone details and delicate sparkle.
The transformation should be elegant and understated.
`,

    "فاخرة": `
Apply a luxurious crystal transformation to the clothing and accessories.

Use dense premium rhinestones with realistic reflections,
while keeping the face, skin and background completely natural.
`,

    "وطنية": `
Use elegant Saudi-inspired green crystal details prominently
on the clothing and accessories.

Maintain a sophisticated Saudi National Day aesthetic.
Keep the face and background natural.
`,

    "كاملة": `
Apply a strong and luxurious crystal transformation to the clothing,
accessories, jewelry and decorative details.

Use rich premium rhinestones and realistic sparkle.

NEVER crystallize the face.
NEVER crystallize the natural background.
`,
  };

  return base + (styles[style] || styles["فاخرة"]);
}

// ============================================================
// Multipart parser
// ============================================================

function parseMultipart(req) {
  return new Promise((resolve, reject) => {
    let resolved = false;

    const bb = Busboy({
      headers: req.headers,
      limits: {
        files: 1,
        fileSize: 10 * 1024 * 1024,
      },
    });

    let imageBuffer = null;
    let filename = "user_photo.png";
    let mimeType = "image/png";
    let style = "فاخرة";

    bb.on("field", (name, value) => {
      if (name === "style" && value) {
        style = value;
      }
    });

    bb.on("file", (name, file, info) => {
      if (name !== "image") {
        file.resume();
        return;
      }

      filename = info?.filename || "user_photo.png";
      mimeType = info?.mimeType || "image/png";

      const chunks = [];

      file.on("data", (chunk) => {
        chunks.push(chunk);
      });

      file.on("end", () => {
        imageBuffer = Buffer.concat(chunks);
      });

      file.on("limit", () => {
        if (resolved) return;

        resolved = true;

        reject(
          new Error(
            "حجم الصورة كبير جدًا. الحد الأقصى 10MB."
          )
        );
      });
    });

    bb.on("error", (error) => {
      if (resolved) return;

      resolved = true;
      reject(error);
    });

    bb.on("finish", () => {
      if (resolved) return;

      resolved = true;

      resolve({
        imageBuffer,
        filename,
        mimeType,
        style,
      });
    });

    req.pipe(bb);
  });
}

// ============================================================
// API Handler
// ============================================================

export default async function handler(req, res) {
  // ==========================================================
  // CORS
  // ==========================================================

  const origin = req.headers.origin;

  res.setHeader(
    "Access-Control-Allow-Origin",
    origin || "*"
  );

  res.setHeader(
    "Access-Control-Allow-Methods",
    "POST, OPTIONS"
  );

  res.setHeader(
    "Access-Control-Allow-Headers",
    "Content-Type, Authorization"
  );

  res.setHeader(
    "Access-Control-Max-Age",
    "86400"
  );

  res.setHeader(
    "Vary",
    "Origin"
  );

  // ==========================================================
  // Preflight
  // ==========================================================

  if (req.method === "OPTIONS") {
    return res.status(204).end();
  }

  // ==========================================================
  // السماح بـ POST فقط
  // ==========================================================

  if (req.method !== "POST") {
    return res.status(405).json({
      error: "Method not allowed",
    });
  }

  try {
    // ========================================================
    // التحقق من API Key
    // ========================================================

    if (!process.env.OPENAI_API_KEY) {
      console.error(
        "OPENAI_API_KEY is missing"
      );

      return res.status(500).json({
        success: false,
        error:
          "OPENAI_API_KEY غير موجود في Vercel.",
      });
    }

    // ========================================================
    // قراءة multipart
    // ========================================================

    const {
      imageBuffer,
      filename,
      mimeType,
      style,
    } = await parseMultipart(req);

    // ========================================================
    // التأكد من وجود الصورة
    // ========================================================

    if (
      !imageBuffer ||
      imageBuffer.length === 0
    ) {
      return res.status(400).json({
        success: false,
        error: "لم يتم إرسال الصورة.",
      });
    }

    // ========================================================
    // التحقق من الحجم
    // ========================================================

    if (
      imageBuffer.length >
      10 * 1024 * 1024
    ) {
      return res.status(400).json({
        success: false,
        error:
          "حجم الصورة كبير جدًا. الحد الأقصى 10MB.",
      });
    }

    console.log(
      "CRYSTAL REQUEST",
      {
        filename,
        mimeType,
        size: imageBuffer.length,
        style,
      }
    );

    // ========================================================
    // تجهيز الصورة لـ OpenAI
    // ========================================================

    const imageFile = await OpenAI.toFile(
      imageBuffer,
      filename,
      {
        type: mimeType,
      }
    );

    // ========================================================
    // إرسال الصورة إلى OpenAI
    // ========================================================

    const result = await client.images.edit({
      model: "gpt-image-2",
      image: imageFile,
      prompt: getPrompt(style),
      size: "1024x1024",
    });

    // ========================================================
    // استخراج الصورة
    // ========================================================

    const imageBase64 =
      result?.data?.[0]?.b64_json;

    if (!imageBase64) {
      console.error(
        "OpenAI response did not contain image"
      );

      return res.status(500).json({
        success: false,
        error:
          "لم يتم استلام الصورة الناتجة من OpenAI.",
      });
    }

    // ========================================================
    // إرسال النتيجة
    // ========================================================

    return res.status(200).json({
      success: true,
      image: imageBase64,
      mimeType: "image/png",
      style,
    });
  } catch (error) {
    // ========================================================
    // تسجيل الخطأ في Vercel
    // ========================================================

    console.error(
      "CRYSTAL ERROR:",
      error
    );

    const errorMessage =
      error?.message ||
      "حدث خطأ أثناء فصفصة الصورة.";

    return res.status(500).json({
      success: false,
      error: errorMessage,
    });
  }
}