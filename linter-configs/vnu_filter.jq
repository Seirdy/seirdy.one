# Filter false positives from the .messages entry of Nu Validator output
.messages |= map(
	. | select(
		.type == "error" and
		(
			( # See https://github.com/w3c/css-validator/issues/361
				.message == "CSS: Parse Error."
				and .extract == "){outline:none}}@media(prefers"
				and .hiliteLength == 1
			)
			or
			( # See https://github.com/validator/validator/issues/1166
				.message == "Attribute “media” not allowed on element “meta” at this point."
				and (.extract | test(" name=\"theme-color\""))
			)
			or
			( # the search page has raw templates, let those slide. I validate the final dynamic search page manually.
				.url | test ("/search/index.")
			)
		) | not
	)
) | del(..|select(. == [])) | del(..|select(. == {})) | select(. != null)
