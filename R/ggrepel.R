#' Repulsive textual annotations
#'
#' `gf_text_repel()` adds a layer of text; `gf_label_repel()` additionally
#' draws a rectangle beneath the text, making it easier to read.  In both
#' cases the labels repel away form each otehr and the data points.
#'
#' @inherit ggformula::gf_text
#' @inherit ggrepel::geom_text_repel
#' @importFrom ggrepel geom_text_repel geom_label_repel
#' @import ggplot2
#'
#' @export
gf_text_repel <-
  ggformula::layer_factory(
    layer_fun = ggrepel::geom_text_repel,
    geom = "text_repel",
    stat = "identity",
    position = "identity",
    aes_form = y ~ x,
    extras = alist(
      label = , alpha = , angle = , color = , family = , fontface = ,
      group = , hjust = , lineheight = , size = , vjust = ,
      parse = FALSE,
      box.padding = 0.25, point.padding = 1e-06,
      segment.colour = NULL, segment.color = NULL,
      segment.size = 0.5, segment.alpha = NULL,
      min.segment.length = 0.5, arrow = NULL, force = 1,
      max.iter = 2000, nudge_x = 0, nudge_y = 0,
      xlim = c(NA, NA), ylim = c(NA, NA),
      direction = c("both", "y", "x"),
      seed = NA
    )
  )

#' @rdname gf_text_repel
#'
#' @export
gf_label_repel <-
  ggformula::layer_factory(
    layer_fun = ggrepel::geom_label_repel,
    geom = "text_repel",
    stat = "identity",
    position = "identity",
    pre = {
      if (nudge_x != 0 || nudge_y != 0)
        position <- position_nudge(nudge_x, nudge_y)
    },
    aes_form = y ~ x,
    extras = alist(
      label = , alpha = , angle = , color = , family = , fontface = ,
      group = , hjust = , lineheight = , size = , vjust = ,
      parse = FALSE,
      box.padding = 0.25, label.padding = 0.25, point.padding = 1e-06,
      label.r = 0.15, label.size = 0.25,
      segment.colour = NULL, segment.color = NULL,
      segment.size = 0.5, segment.alpha = NULL,
      min.segment.length = 0.5, arrow = NULL, force = 1,
      max.iter = 2000, nudge_x = 0, nudge_y = 0,
      xlim = c(NA, NA), ylim = c(NA, NA),
      direction = c("both", "y", "x"),
      seed = NA
    )
  )

#' @examples
#' mtcars$model <- rownames(mtcars)
#' mtcars$cylinders <- factor(mtcars$cyl)
#'
#' p <-
#'   gf_point(mpg ~ wt, data = mtcars, color = ~ cylinders)
#'
#' # Avoid overlaps by repelling text labels
#' p %>% gf_text_repel(label = ~ model)
#'
#' # Labels with background
#' p %>% gf_label_repel(label = ~ model)
#'
#' # Add aesthetic mappings
#' p %>% gf_text_repel(alpha = ~ wt, size = ~ mpg, label = ~ model)
#' p %>% gf_label_repel(label = ~ model,
#'                      fill = ~ factor(cyl), color = "white", segment.color = "black")
#'
#' # Draw all line segments
#' p %>% gf_text_repel(label = ~ model, min.segment.length = 0)
#'
#' # Omit short line segments (default behavior)
#' p %>% gf_text_repel(label = ~ model, min.segment.length = 0.5)
#'
#' # Omit all line segments
#' p %>% gf_text_repel(label = ~ model, segment.colour = NA)
#' p %>% gf_text_repel(label = ~ model, min.segment.length = Inf)
#'
#' # Repel just the labels and totally ignore the data points
#' p %>% geom_text_repel(label = ~ model, point.padding = NA)
#'
#' # Hide some of the labels, but repel from all data points
#' mtcars$label <- rownames(mtcars)
#' mtcars$label[1:15] <- ""
#' p %>% gf_text_repel(data = mtcars, label = ~ label)
#'
#' # Nudge the starting positions
#' p %>% gf_text_repel(
#'         label = ~ model,
#'         nudge_x = ifelse(mtcars$cyl == 6, 2, 0),
#'         nudge_y = ifelse(mtcars$cyl == 6, 7, 0))
#'
#' # Change the text size
#' p %>% gf_text_repel(label = ~ model, size = ~ wt)
#'
#' # Scale height of text, rather than sqrt(height)
#' p %>%
#'   gf_text_repel(label = ~ model, size = ~ wt) %>%
#'   gf_refine(scale_radius(range = c(3, 6)))
#'
#' # You can display expressions by setting parse = TRUE.  The
#' # details of the display are described in `?plotmath`, but note that
#' # `gf_text_repel()` uses strings, not expressions.
#' p %>%
#'   gf_text_repel(label = ~ paste(wt, "^(", cyl, ")", sep = ""),
#'                   parse = TRUE)
#'
#' # Add arrows
#' p %>%
#'   gf_point(colour = "black") %>%
#'   gf_text_repel(
#'     label = ~ model,
#'     arrow = arrow(length = unit(0.02, "npc")),
#'     box.padding = 1
#'   )

