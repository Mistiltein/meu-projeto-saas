import "dotenv/config";
import { defineConfig, env } from "prisma/config";

export default defineConfig({
  schema: "prisma/schema.prisma",

  migrations: {
    path: "prisma/migrations",
  },

  datasource: {
    // URL usada pelo Prisma CLI (migrations, db push, etc.)
    url: env("DATABASE_URL"),
  },
});
