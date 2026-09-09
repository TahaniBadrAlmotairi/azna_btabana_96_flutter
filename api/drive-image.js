export default async function handler(req, res) {
  res.setHeader(
    "Access-Control-Allow-Origin",
    "*"
  );

  res.setHeader(
    "Access-Control-Allow-Methods",
    "GET, OPTIONS"
  );

  res.setHeader(
    "Access-Control-Allow-Headers",
    "Content-Type"
  );

  if (req.method === "OPTIONS") {
    return res.status(204).end();
  }

  if (req.method !== "GET") {
    return res.status(405).json({
      error: "Method not allowed",
    });
  }

  const { id } = req.query;

  if (!id) {
    return res.status(400).json({
      error: "Missing id",
    });
  }

  try {
    // نحاول جلب الصورة مباشرة من Google
    const googleUrl =
      `https://lh3.googleusercontent.com/d/${encodeURIComponent(id)}=w1200`;

    const response = await fetch(googleUrl);

    if (!response.ok) {
      console.error(
        "Google response:",
        response.status
      );

      return res.status(502).json({
        error: "Google Drive image could not be loaded",
        status: response.status,
      });
    }

    const contentType =
      response.headers.get("content-type") ||
      "image/png";

    const buffer = Buffer.from(
      await response.arrayBuffer()
    );

    res.setHeader(
      "Content-Type",
      contentType
    );

    res.setHeader(
      "Cache-Control",
      "public, max-age=86400"
    );

    return res.status(200).send(buffer);

  } catch (error) {
    console.error(
      "Drive proxy error:",
      error
    );

    return res.status(500).json({
      error: "Internal server error",
    });
  }
}