CREATE TABLE IF NOT EXISTS "raksapankki_post" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" varchar(256),
	"createdById" varchar(255) NOT NULL,
	"created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"updatedAt" timestamp with time zone
);
--> statement-breakpoint
ALTER TABLE "raksapankki_user" ALTER COLUMN "id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "raksapankki_user" ALTER COLUMN "id" SET DEFAULT uuid_generate_v4();--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "raksapankki_post" ADD CONSTRAINT "raksapankki_post_createdById_raksapankki_user_id_fk" FOREIGN KEY ("createdById") REFERENCES "public"."raksapankki_user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "createdById_idx" ON "raksapankki_post" USING btree (createdById);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "name_idx" ON "raksapankki_post" USING btree (name);