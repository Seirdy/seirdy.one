# I regularly validate every page with the Nu HTML Checker.
# It has false positives; I report them upstream and silence them here.
# I use jq/jaq to remove them from the JSON output.
.messages |= map(
	. | select(
		.type == "info" and (
			.message == "Trailing slash on void elements has no effect and interacts badly with unquoted attribute values."
			and (.url | test(".html"))
		) or
		.type == "error" and (
			( # see https://github.com/w3c/css-validator/issues/369
				.message == "CSS: “contain-intrinsic-size”: Property “contain-intrinsic-size” doesn't exist."
			) or
			( # see https://github.com/w3c/css-validator/issues/370
				.message == "CSS: “contain”: “inline-size” is not a “contain” value."
			) or
			( # See https://github.com/w3c/css-validator/issues/361
				.message == "CSS: Parse Error."
				and .extract == "not(:focus-visible){outline:no"
				and (.url | test(".xhtml"))
				and .hiliteLength == 1
			) or
			( # See https://github.com/w3c/css-validator/issues/361
				.message == "CSS: Parse Error."
				and .extract == "){outline:none}}@media(prefers"
				and .hiliteLength == 1
			)
		) | not
	)
) | del(..|select(. == [])) | del(..|select(. == {})) | select(. != null)
