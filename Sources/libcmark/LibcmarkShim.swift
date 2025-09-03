//
//  LibcmarkShim.swift
//  Down
//
//  Created by Chien Shing Ooi on 03/09/2025.
//

@_exported import cmark_gfm
@_exported import cmark_gfm_extensions

// Back-compat wrapper so Down's old two-arg call keeps compiling.
@inlinable
public func cmark_render_html(
  _ root: UnsafeMutablePointer<cmark_node>!,
  _ options: Int32
) -> UnsafeMutablePointer<CChar>! {
  // Pass no extension list (nil). You can construct one later if you want GFM rendering features.
  return cmark_gfm.cmark_render_html(root, options, nil)
}
