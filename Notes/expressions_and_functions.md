
```
# This command starts a REPL, R E P L, which stands for read-evaluate-print loop.
# A REPL is an interactive program that accepts input, evaluates it, and prints
# a result. The loop is the prompt for the next input. Our Linux command prompt
# is an example of a REPL, as is any interactive or shell program that accepts input
# in this way. We can use Terraform Console to experiment with expressions and functions.
# The commands we execute here will work exactly the same as if they were part of a configuration.

terraform console

# conditional statement or ternary statement
# if 5 is not equal to 5 then(?) "foo", else, "bar"
> 5 != 5 ? "foo" : "bar"
"bar"
# if 4 is not equal to 5 then(?) "foo", else, "bar"
> 4 != 5 ? "foo" : "bar"
"foo"
# This is called a ternary operator. It's like an if statement, but it can only
# evaluate to a single result value. If the conditional part here is true, then
# the first element after the question mark is the result of the expression.
# If false, the second element after the colon becomes the result.


## some functions
> length("terraform")
9
> upper("terraform")
"TERRAFORM"
> split(",", "one,two,three")
tolist([
  "one",
  "two",
  "three",
])
> join(",", ["one", "two", "three"])
"one,two,three"

## interacting with the terraform state
> google_compute_subnetwork.subnet-1
(known after apply)
> google_compute_instance.web-instances[*].network_interface[0]
```