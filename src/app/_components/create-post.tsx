"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

import { api } from "~/trpc/react";

export function CreatePost() {
  const router = useRouter();
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");

  const createPlan = api.workPhasePlan.create.useMutation({
    onSuccess: () => {
      router.refresh();
      setName("");
      setDescription("");
    },
  });

  return (
    <form
      onSubmit={(e) => {
        e.preventDefault();
        createPlan.mutate({ name, description });
      }}
      className="flex flex-col gap-5"
    >
      <input
        type="text"
        placeholder="Title"
        value={name}
        onChange={(e) => setName(e.target.value)}
        className="w-full rounded-lg px-4 py-2 text-black"
      />
      <textarea
        placeholder="Description"
        value={description}
        onChange={(e) => setDescription(e.target.value)}
        rows={4}
        cols={50}
        className="w-full rounded-lg px-4 py-2 text-black"
      />
      <button
        type="submit"
        className="rounded-lg bg-white/10 px-10 py-3 font-semibold transition hover:bg-white/20"
        disabled={createPlan.isPending}
      >
        {createPlan.isPending ? "Submitting..." : "Submit"}
      </button>
    </form>
  );
}
