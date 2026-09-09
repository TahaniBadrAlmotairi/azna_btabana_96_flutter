export default async function handler(req, res) {
  // CORS
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
    const googleUrl =
      `https://lh3.googleusercontent.com/d/${encodeURIComponent(id)}=w1200`;

    const response = await fetch(googleUrl);

    if (!response.ok) {
      console.error(
        "Google response:",
        response.status
      );

      return res.status(502).json({
        error: "Google image could not be loaded",
        status: response.status,
      });
    }

    const contentType =
      response.headers.get("content-type") ||
      "image/png";

    const arrayBuffer =
      await response.arrayBuffer();

    const base64 =
      Buffer.from(arrayBuffer).toString("base64");

    return res.status(200).json({
      success: true,
      mimeType: contentType,
      image: base64,
    });

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