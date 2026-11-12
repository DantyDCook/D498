# LocalCI data and notebook validation (proposal)

This is a **declarative**, source-committed contract only; it does **not** automatically run tests or approve external data downloads. The central LocalCI engine and independently reviewed policy must be installed and tested before activation.

Proposed checks: notebook-json-integrity, r-script-parse, geodata-artifact-manifest, reproducibility-metadata. Execute against synthetic fixtures or already-authorized local data; never assume that notebooks may download private datasets or that baseline results can be reproduced without their dependencies.

Use the immutable approved source commit, fail closed if dependencies or data are unavailable, and preserve protected credentials and central policy.

Design RFC: https://github.com/DantyDCook/local-ci-bootstrap-test/pull/5
