ALTER TABLE "raksapankki_user" RENAME COLUMN "id" TO "uuid2";--> statement-breakpoint
ALTER TABLE "raksapankki_account" DROP CONSTRAINT "raksapankki_account_userId_raksapankki_user_id_fk";
--> statement-breakpoint
ALTER TABLE "raksapankki_post" DROP CONSTRAINT "raksapankki_post_createdById_raksapankki_user_id_fk";
--> statement-breakpoint
ALTER TABLE "raksapankki_session" DROP CONSTRAINT "raksapankki_session_userId_raksapankki_user_id_fk";
--> statement-breakpoint
/* 
    Unfortunately in current drizzle-kit version we can't automatically get name for primary key.
    We are working on making it available!

    Meanwhile you can:
        1. Check pk name in your database, by running
            SELECT constraint_name FROM information_schema.table_constraints
            WHERE table_schema = 'public'
                AND table_name = 'raksapankki_user'
                AND constraint_type = 'PRIMARY KEY';
        2. Uncomment code below and paste pk name manually
        
    Hope to release this update as soon as possible
*/

-- ALTER TABLE "raksapankki_user" DROP CONSTRAINT "<constraint_name>";--> statement-breakpoint
ALTER TABLE "raksapankki_user" ALTER COLUMN "uuid2" DROP NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "raksapankki_account" ADD CONSTRAINT "raksapankki_account_userId_raksapankki_user_uuid2_fk" FOREIGN KEY ("userId") REFERENCES "public"."raksapankki_user"("uuid2") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "raksapankki_post" ADD CONSTRAINT "raksapankki_post_createdById_raksapankki_user_uuid2_fk" FOREIGN KEY ("createdById") REFERENCES "public"."raksapankki_user"("uuid2") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "raksapankki_session" ADD CONSTRAINT "raksapankki_session_userId_raksapankki_user_uuid2_fk" FOREIGN KEY ("userId") REFERENCES "public"."raksapankki_user"("uuid2") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
