ALTER TABLE "raksapankki_account" ALTER COLUMN "userId" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "raksapankki_post" ALTER COLUMN "createdById" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "raksapankki_session" ALTER COLUMN "userId" DROP NOT NULL;