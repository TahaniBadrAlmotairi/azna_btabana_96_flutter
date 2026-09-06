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

function getPrompt(style) {
  const base = `
Edit the uploaded person's photo into a premium Saudi National Day 96
crystal/rhinestone fashion style.

CRITICAL REQUIREMENTS:

- Preserve the person's identity exactly.
- Keep the face natural, realistic and photorealistic.
- Do NOT crystallize the face.
- Do NOT change facial features.
- Preserve eyes, eyebrows, nose, mouth, skin texture and expression.
- Preserve the person's body shape, pose and proportions.
- Keep the background natural and realistic.
- Do NOT crystallize the entire photograph.

The main crystal transformation must be focused on:
- clothing
- fabric
- accessories
- jewelry
- decorative elements

The crystals should look like premium glass rhinestones,
with elegant reflections, sparkle and realistic lighting.

The final image must look like a real professional photograph,
not a cartoon, illustration or fantasy character.

Saudi National Day 96 aesthetic:
- elegant Saudi green accents
- luxurious crystal details
- refined national feeling
- premium editorial photography
`;

  const styles = {
    "خفيفة": `
Apply a subtle and elegant amount of crystal.
Keep most clothing realistic with small sparkling crystal details.
`,
    "فاخرة": `
Apply a luxurious crystal transformation to the clothing and accessories.
Use dense premium rhinestones while keeping the face and background natural.
`,
    "وطنية": `
Use Saudi-inspired green crystal details prominently on the clothing
and accessories while maintaining an elegant national aesthetic.
`,
    "كاملة": `
Apply a strong and luxurious crystal transformation to the clothing,
accessories and decorative details, while NEVER crystallizing the face
or the natural background.
`,
  };

  return base + (styles[style] || styles["فاخرة"]);
}

function parseMultipart(req) {
  return new Promise((resolve, reject) => {
    const bb = Busboy({
      headers: req.headers,
      limits: {
        files: 1,
        fileSize: 10 * 1024 * 1024,
      },
    });

    let imageBuffer = null;
    let filename = "photo.jpg";
    let mimeType = "image/jpeg";
    let style = "فاخرة";

    bb.on("field", (name, value) => {
      if (name === "style") {
        style = value;
      }
    });

    bb.on("file", (name, file, info) => {
      if (name !== "image") {
        file.resume();
        return;
      }

      filename = info.filename || filename;
      mimeType = info.mimeType || mimeType;

      const chunks = [];

      file.on("data", (chunk) => {
        chunks.push(chunk);
      });

      file.on("end", () => {
        imageBuffer = Buffer.concat(chunks);
      });

      file.on("limit", () => {
        reject(new Error("حجم الصورة كبير جدًا. الحد الأقصى 10MB."));
      });
    });

    bb.on("error", reject);

    bb.on("finish", () => {
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

export default async function handler(req, res) {
  // CORS
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type");

  if (req.method === "OPTIONS") {
    return res.status(204).end();
  }

  if (req.method !== "POST") {
    return res.status(405).json({
      error: "Method not allowed",
    });
  }

  try {
    const {
      imageBuffer,
      filename,
      mimeType,
      style,
    } = await parseMultipart(req);

    if (!imageBuffer || imageBuffer.length === 0) {
      return res.status(400).json({
        error: "لم يتم إرسال الصورة.",
      });
    }

    console.log("Image received:", {
      filename,
      mimeType,
      size: imageBuffer.length,
      style,
    });

    const imageFile = await OpenAI.toFile(
      imageBuffer,
      filename,
      {
        type: mimeType,
      }
    );

    const result = await client.images.edit({
      model: "gpt-image-2",
      image: imageFile,
      prompt: getPrompt(style),
      size: "1024x1024",
    });

    const imageBase64 = result.data?.[0]?.b64_json;

    if (!imageBase64) {
      throw new Error("لم يتم استلام الصورة الناتجة من OpenAI.");
    }

    return res.status(200).json({
      success: true,
      image: imageBase64,
      mimeType: "image/png",
      style,
    });

  } catch (error) {
    console.error("CRYSTAL ERROR:", error);

    return res.status(500).json({
      success: false,
      error:
        error?.message ||
        "حدث خطأ أثناء فصفصة الصورة.",
    });
  }
}