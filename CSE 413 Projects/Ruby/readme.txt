
# Hastin Kapoor
# 2061247

Crashes if undefined variable used in equation. However, it cannot exit before
evaluating the entire program in order to catch all undefined variables used.

While it does not explicitly disallow assigning of keywords, they will be evaluated
as the keyword rather than an identifier for assigning, and thus will not be assigned
(and likely crash the calculator if used inccorectly).

Otherwise, the calculator does as listed in the specification, as well as printing
meaningful messages after assigning or clearing variables.