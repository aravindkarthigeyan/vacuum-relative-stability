# Companion notes: extraction and scope

The new companion document collects the existing frozen-link, clover,
electric-localization, and local-remainder proofs. It does not add a
new dynamical nonrelativistic claim.

## Provenance

- low-energy-matching.tex, electric-localization.tex, and
  source-relative-remainders.tex are byte-for-byte copies of those
  inputs in the consolidated 64-page draft.
- model.tex supplies all operator definitions, domains, the elementary
  energy bound, and the exact source/self-energy convention needed to
  read those sections. Its full source comparison is explicitly recalled
  from Paper A rather than presented as proved a second time.
- scope.tex records the logical boundary without adding conjectural
  estimates. The bibliography is reduced to the actually used sources
  and an explicit unpublished reference to Paper A.
- prepare_companion.py makes the extraction reproducible. It leaves
  model.tex and scope.tex as maintained source files.

## Two precision points in the incoming brief

The fixed-link inequality |h_W(U)|>=m already follows from the proved
Schur-complement argument, despite noncommutation of the spatial mass
and hopping matrices. It also supplies the static quadratic pair cost
relative to that same frozen sea. The electric dynamics is precisely
what prevents transferring this conclusion to the full Hamiltonian.

The bare-vacuum counterexamples prove positive total excitation number
and nonzero electric tails. Their proofs do not establish a positive
lower density uniformly in growing volume. Likewise, the quantified
iron benchmark rules out the specified resolved heavy-lattice hierarchy
at the stated tolerances, rather than all possible nonrelativistic
approximations to iron.

## Document verification

The document has 20 pages, compiles without warnings or unresolved
references, and all pages were rendered and visually inspected.
The desktop editor compiler independently succeeded.
Its source ZIP was compiled from a fresh extraction and reproduced the
same PDF text. The external manifest records hashes and checks.

Internal audits and document checks do not substitute for external
specialist review. Research-tool credits remain Opus 5.5 + Astra 6;
human authorship is unset.
