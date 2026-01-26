# Tutorial v0.1 — Your First Recorded Failure

> This tutorial intentionally leads to a **FAIL**.
> It does not teach best practices, security, or policy design.
> Its sole purpose is to demonstrate **what Policy Authority records** and **what it refuses to record**.

---

## What You Will Learn (and What You Will Not)

You will learn:
- How a Frame defines a boundary
- How a Snapshot becomes **inadmissible**
- What a FAIL verdict actually fixes in time

You will **not** learn:
- How to write good policies
- How to pass validation
- How to secure Terraform or Kubernetes

---

## Step 0 — Preconditions

This tutorial assumes:
- You have a working `policy-authority` CLI (v0.1)
- You are not trying to "do the right thing"

---

## Step 1 — Create a Minimal Frame

Create a new Frame directory:

```
frames/tutorial/
```

Create `FRAME_CONSTITUTION.md` with the following content:

```
# Tutorial Frame (v0.1)

This Frame exists only to demonstrate a recorded failure.
```

Create `SNAPSHOT_FRAME.md`:

```
boundaries:
  - id: no-latest-tag
    description: Images tagged with :latest are forbidden
    match:
      files: ["**/*.yaml"]
      contains: [":latest"]

invariants:
  - id: owner-required
    description: Every resource must declare an owner
    match:
      files: ["**/*.yaml"]
      contains: ["owner:"]
```

This is intentionally trivial.

---

## Step 2 — Create a Snapshot That Must Fail

Create a snapshot directory:

```
snapshots/tutorial/failure-case/
```

Inside it, create `deployment.yaml`:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo
spec:
  template:
    spec:
      containers:
        - name: app
          image: nginx:latest
```

This file:
- **Violates the boundary** (`:latest` present)
- **Violates the invariant** (`owner:` missing)

---

## Step 3 — Run the Engine

Execute:

```
policy-authority check \
  --frame frames/tutorial \
  --snapshot snapshots/tutorial/failure-case
```

You are expected to receive:

```
verdict: FAIL
```

---

## Step 4 — Read the Verdict (Slowly)

Open the emitted verdict file.

Observe:
- `verdict = FAIL`
- At least one `violation.id`
- A stable `snapshot.hash`

The Engine does **not** say:
- Why this is dangerous
- How to fix it
- What you should do next

It only says:

> "This snapshot is not admissible under the declared rules."

---

## Step 5 — Understand What Just Happened

This FAIL means:

- Someone declared that `:latest` must not appear
- Someone declared that `owner:` must always exist
- This snapshot contradicts those declarations
- Therefore, **it cannot be recorded**

The Engine:
- Did not understand Kubernetes
- Did not understand containers
- Did not interpret security meaning

It only matched text.

---

## Step 6 — The Fixed Point

This is the critical realization:

> This FAIL is now a **fixed historical fact**.

- Re-running the Engine yields the same result
- Improving the YAML does not change this verdict
- Changing the rules would require a **new snapshot or new Frame**

Nothing about this failure can be reinterpreted later.

---

## Final Note

If this tutorial felt unhelpful, that is intentional.

Policy Authority does not help you decide.
It helps you **prove that a decision boundary existed**.

If you understand why this failure was worth recording,
then you understand the system.

---

End of tutorial.

