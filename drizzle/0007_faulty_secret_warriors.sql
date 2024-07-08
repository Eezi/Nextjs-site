ALTER TABLE "raksapankki_account" DROP CONSTRAINT "raksapankki_account_userId_raksapankki_user_uuid2_fk";
--> statement-breakpoint
ALTER TABLE "raksapankki_post" DROP CONSTRAINT "raksapankki_post_createdById_raksapankki_user_uuid2_fk";
--> statement-breakpoint
ALTER TABLE "raksapankki_session" DROP CONSTRAINT "raksapankki_session_userId_raksapankki_user_uuid2_fk";
--> statement-breakpoint
ALTER TABLE "raksapankki_user" ADD COLUMN "id" varchar(255) NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "raksapankki_account" ADD CONSTRAINT "raksapankki_account_userId_raksapankki_user_id_fk" FOREIGN KEY ("userId") REFERENCES "public"."raksapankki_user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "raksapankki_post" ADD CONSTRAINT "raksapankki_post_createdById_raksapankki_user_id_fk" FOREIGN KEY ("createdById") REFERENCES "public"."raksapankki_user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "raksapankki_session" ADD CONSTRAINT "raksapankki_session_userId_raksapankki_user_id_fk" FOREIGN KEY ("userId") REFERENCES "public"."raksapankki_user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
ALTER TABLE "raksapankki_user" DROP COLUMN IF EXISTS "uuid2";