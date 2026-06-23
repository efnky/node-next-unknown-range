# node-next-unknown-range ⚠️

A Next.js dependency declared as an **ambiguous version range that spans the 16
boundary**: `"next": ">=15.0.0 <17.0.0"`, with **no committed lockfile**.

## Expected on deploy
**DZNODE001 WARNING.** The range allows both Next <16 (webpack default, safe)
and Next ≥16 (Turbopack default, panic-prone), and there is no lockfile to pin a
concrete version. The `BuildpackPreflightLinter` cannot decide whether Turbopack
will be the default, so instead of a hard ERROR it should emit a **WARNING**.

This intentionally breaks the "pin your versions" rule — the unresolved range is
the whole point of the test. Do not pin `next` and do not commit a lockfile.

## Run
```bash
npm install   # resolves to the highest allowed (currently a 16.x)
npm run build
```
