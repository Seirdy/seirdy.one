# Filter false positives from the .messages entry of Nu Validator output
.messages |= map(
	. | select(
		.type == "info" and (
			.message == "Trailing slash on void elements has no effect and interacts badly with unquoted attribute values."
			and (.url | test(".html"))
		) or
		.type == "error" and (
			( # See https://github.com/validator/validator/issues/1166
			  # This false-positive has been fixed; will remove once validator.nu updates
				# validator.w3.org/nu is up-to-date.
				.message == "Attribute “media” not allowed on element “meta” at this point."
				and (.extract | test(" name=\"theme-color\""))
			) or
			( # see https://github.com/w3c/css-validator/issues/369
				.message == "CSS: “contain-intrinsic-size”: Property “contain-intrinsic-size” doesn't exist."
			) or
			( # see https://github.com/w3c/css-validator/issues/370
				.message == "CSS: “contain”: “inline-size” is not a “contain” value."
			) or
			( # See https://github.com/w3c/css-validator/issues/361
				.message == "CSS: Parse Error."
				and .extract == "not(:focus-visible){outline:no"
				and (.url | test("index.xhtml"))
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
