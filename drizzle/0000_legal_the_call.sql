CREATE TABLE IF NOT EXISTS "raksapankki_account" (
	"userId" varchar(255) NOT NULL,
	"type" varchar(255) NOT NULL,
	"provider" varchar(255) NOT NULL,
	"providerAccountId" varchar(255) NOT NULL,
	"refresh_token" text,
	"access_token" text,
	"expires_at" integer,
	"token_type" varchar(255),
	"scope" varchar(255),
	"id_token" text,
	"session_state" varchar(255),
	CONSTRAINT "raksapankki_account_provider_providerAccountId_pk" PRIMARY KEY("provider","providerAccountId")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "raksapankki_post" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" varchar(256),
	"createdById" varchar(255) NOT NULL,
	"created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"updatedAt" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "raksapankki_session" (
	"sessionToken" varchar(255) PRIMARY KEY NOT NULL,
	"userId" varchar(255) NOT NULL,
	"expires" timestamp with time zone NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "raksapankki_user" (
	"id" varchar(255) PRIMARY KEY NOT NULL,
	"name" varchar(255),
	"email" varchar(255) NOT NULL,
	"emailVerified" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
	"image" varchar(255)
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "raksapankki_verificationToken" (
	"identifier" varchar(255) NOT NULL,
	"token" varchar(255) NOT NULL,
	"expires" timestamp with time zone NOT NULL,
	CONSTRAINT "raksapankki_verificationToken_identifier_token_pk" PRIMARY KEY("identifier","token")
);
--> statement-breakpoint
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
CREATE INDEX IF NOT EXISTS "account_userId_idx" ON "raksapankki_account" USING btree (userId);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "createdById_idx" ON "raksapankki_post" USING btree (createdById);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "name_idx" ON "raksapankki_post" USING btree (name);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "session_userId_idx" ON "raksapankki_session" USING btree (userId);