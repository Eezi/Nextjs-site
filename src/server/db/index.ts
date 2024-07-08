import { neon } from "@neondatabase/serverless";
import { drizzle } from "drizzle-orm/neon-http";
import * as schema from "./schema";

const sql = neon(process.env.DATABASE_URL!);

export const db = drizzle(sql, { schema });

// const sql = neon(process.env.DATABASE_URL!);
// export const db = drizzle(sql);
// Use neon to create the connection
// const sql = neon(env.DATABASE_URL);

/**
 * Cache the database connection in development. This avoids creating a new connection on every HMR
 * update.
 */
 /*const globalForDb = globalThis as unknown as {
  conn: postgres.Sql<{}> | undefined;
};*/

/*const conn =
  globalForDb.conn ?? postgres({ connectionString: env.DATABASE_URL });
if (env.NODE_ENV !== "production") globalForDb.conn = conn;

export const db = drizzle(sql, { schema });*/
