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
				and .firstColumn == 1
				and (.extract | test(" name=\"theme-color\""))
			)
			or
			( # XHTML5 gang
				.message == "Bad value “application/xhtml+xml; charset=utf-8” for attribute “content” on element “meta”: The legacy encoding declaration did not start with “text/html;”."
				and .firstColumn == 1
			)
		) | not
	)
)
