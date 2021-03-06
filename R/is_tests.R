#' Test if a string is a lineage
#'
#' @param string string.
#' @param sep string. Rank separator. Default to \code{\\\\|} but
#' \code{;} could be used too.
#'
#' @return A logical.
#' @importFrom stringr str_detect
#' @export
#'
#' @examples
#' is_lineage("k__Bacteria|p__Firmicutes|c__Clostridia|o__Clostridiales")
is_lineage <- function(string, sep = "\\|"){
  str_detect(string, paste0("^k__", .allchr, "*",
                            "($|", sep ,"p__", .allchr, "*)",
                            "($|", sep ,"c__", .allchr, "*)",
                            "($|", sep ,"o__", .allchr, "*)",
                            "($|", sep ,"f__", .allchr, "*)",
                            "($|", sep ,"g__", .allchr, "*)",
                            "($|", sep ,"s__", .allchr, "*)",
                            "($|", sep ,"t__", .allchr, "*)$"))
}



#' Test if a lineage goes down to a specified rank
#'
#' @param lineage string. Vector of lineages.
#' @param rank string. One of \code{c("kingdom", "phylum", "class",
#' "order", "family", "genus", "species", "strain")} with partial matching.
#' @param sep string. Rank separator. Default to \code{\\\\|} but
#' \code{;} could be used too.
#'
#' @return logical.
#' @importFrom stringr str_sub str_detect
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' is_rank(c(lineage1, lineage2), "class")
#' is_rank(c(lineage1, lineage2), "order")
is_rank <- function(lineage,
                    rank = c("kingdom", "phylum", "class", "order",
                             "family", "genus", "species", "strain"),
                    sep = "\\|") {

  error_lineage(lineage, sep = sep)

  rank <- match.arg(rank)
  letter <- ifelse(rank == "strain", "t", str_sub(rank, end = 1))

  str_detect(lineage, paste0(letter, "__", .allchr, "*$"))
  }


#' Test if a lineage belongs to a clade
#'
#' @details  If \code{rank} is set to \code{.}, clade is looked for among all ranks.
#'
#' @param lineage string. Vector of lineages.
#' @param clade string.
#' @param rank string. One of \code{c(".", "kingdom", "phylum", "class",
#' "order", "family", "genus", "species", "strain")} with partial matching.
#' @param sep string. Rank separator. Default to \code{\\\\|} but
#' \code{;} could be used too.
#'
#' @return logical.
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' is_clade(c(lineage1, lineage2), clade = "Verrucomicrobia", rank = "phylum")
#' is_clade(c(lineage1, lineage2), clade = "Clostridia")
is_clade <- function(lineage, clade,
                     rank = c(".", "kingdom", "phylum", "class", "order",
                              "family", "genus", "species", "strain"),
                     sep = "\\|") {

  error_lineage(lineage, sep = sep)

  stopifnot(length(clade) == 1)

  rank <- match.arg(rank)
  letter <- ifelse(rank == "strain", "t", str_sub(rank, end = 1))

  str_detect(lineage, paste0("(^|", sep, ")", letter,
                             "__", clade, "($|", sep, ")"))

}

