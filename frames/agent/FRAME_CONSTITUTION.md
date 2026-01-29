# Agent Frame Constitution

## Scope
This Frame defines policy boundaries applicable to AI agents operating
within a repository context.

## Sub-Frame Admission
This Frame MAY be partitioned into sub-frames.

A sub-frame:
- MUST reside under this Frame directory.
- MUST declare its own FRAME_CONSTITUTION.md.
- MUST NOT reference, include, or depend on other sub-frames.
- Is evaluated independently by the Engine.

The existence or absence of sub-frames does not change the authority,
scope, or guarantees of this parent Frame.
