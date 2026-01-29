# Frame Constitution — Kubernetes Network Sub-Frame (v0.1)
Version: v0.1
Status: Normative (Sub-Frame-Binding)
Applies-To: Kubernetes/Network Sub-Frame
Last-Updated: 2026-01-29

---

## 1. Scope
- Covers static Kubernetes manifest content relevant to network configuration (e.g., Services, Ingress, NetworkPolicies, CNI-specific annotations).
- Excludes security hardening, compute/scheduling, storage, performance tuning, or other sub-frame scopes.
- Any requirement outside this scope is constitutionally out of bounds.

## 2. Determinism Commitment
Snapshots derive solely from repository files; no execution, network access, clocks, or external state are permitted.

## 3. Execution Exclusions
Refuses running kubectl, cluster queries, simulations, or tool invocation. File inspection only.

## 4. Non-Interpretation
No semantic judgement of operational correctness or intent; evaluation is glob + substring only.

## 5. Fail-Only Guarantee
Outcomes are PASS with zero violations or FAIL with one or more violations. No auto-correction or partial results.

## 6. Independence
- Self-contained: MUST NOT reference, import, or depend on other sub-frames or shared bundles.
- Evaluated independently; other sub-frames cannot satisfy or override this scope.

## 7. Self-Invalidation
Violation of any commitment invalidates this sub-frame; past evaluations must not be relied upon.
