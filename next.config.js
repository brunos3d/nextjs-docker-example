/** @type {import('next').NextConfig} */
const nextConfig = {
  // required by dockerfile
  output: 'standalone',
  reactStrictMode: true,
  swcMinify: true,
}

module.exports = nextConfig
