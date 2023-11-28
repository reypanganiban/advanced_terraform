map (or object) - a group of values identified by named labels
ex:
```
{
  name = "Rey",
  position = "DevOps"
}
```

toset fuction - converts its argument to a set value. Explicit type conversions are rarely necessary in Terraform because it will convert types automatically where required. 
Use the explicit type conversion functions only to normalize types returned in module outputs. Pass a list value to toset to convert it to a set, which will remove any duplicate elements and discard the ordering of the elements.
```
> toset(["a", "b", "c"])
[
  "a",
  "b",
  "c",
]
```
Since Terraform's concept of a set requires all of the elements to be of the same type, mixed-typed elements will be converted to the most general type:
```
> toset(["a", "b", 3])
[
  "3",
  "a",
  "b",
]
```
Set collections are unordered and cannot contain duplicate values, so the ordering of the argument elements is lost and any duplicate values are coalesced
```
> toset(["c", "b", "b"])
[
  "b",
  "c",
]
```

setproduct - The setproduct function finds all of the possible combinations of elements from all of the given sets by computing the Cartesian product.
```
> setproduct(["development", "staging", "production"], ["app1", "app2"])
[
  [
    "development",
    "app1",
  ],
  [
    "development",
    "app2",
  ],
  [
    "staging",
    "app1",
  ],
  [
    "staging",
    "app2",
  ],
  [
    "production",
    "app1",
  ],
  [
    "production",
    "app2",
  ],
]
```
```
> setproduct(["dev", "qa", "staging", "prod"], ["roles/viewer", "roles.storage.objectViewer"])
tolist([
[
  "dev",
  "roles/viewer",
],
[
  "dev",
  "roles.storage.objectViewer",
],
[
  "qa",
  "roles/viewer",
],
[
  "qa",
  "roles.storage.objectViewer",
],
[
  "staging",
  "roles/viewer",
],
[
  "staging",
  "roles.storage.objectViewer",
],
[
  "prod",
  "roles/viewer",
],
[
  "prod",
  "roles.storage.objectViewer",
],
])
```

zipmap - constructs a map from a list of keys and a corresponding list of values `zipmap(keyslist, valueslist)`
```
> zipmap(["dev-viewer", "dev-objectViewer"], [{name="dev", role="roles/viewer"}, {name="dev", role="roles/objectViewer"}])
{
  "dev-objectViewer" = {
    "name" = "dev"
    "role" = "roles/objectViewer"
  }
  "dev-viewer" = {
    "name" = "dev"
    "role" = "roles/viewer"
  }
}
```
Both keyslist and valueslist must be of the same length. keyslist must be a list of strings, while valueslist can be a list of any type.
Each pair of elements with the same index from the two lists will be used as the key and value of an element in the resulting map. If the same value appears multiple times in keyslist then the value with the highest index is used in the resulting map.
```
> zipmap(["a", "b"], [1, 2])
{
  "a" = 1
  "b" = 2
}
```
