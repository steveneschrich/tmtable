% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_snapshot.R
\name{add_snapshot}
\alias{add_snapshot}
\title{Add a snapshot}
\usage{
add_snapshot(v, snapshot, as_of = lubridate::now())
}
\arguments{
\item{v}{A vibble}

\item{snapshot}{A new table with the same structure as vibble (without version data).}

\item{as_of}{A date to update information as of (YYYY-MM-DD format).}
}
\value{
An updated vibble with newtbl merged in.
}
\description{
Given a data frame, update the tmtable by adding new rows
and documenting removed rows. Changed rows show up as removed rows (existing data)
and added rows (new data).
}
\details{
The algorithm involves comparing the \code{v} and
\code{newtbl} for differences and annotating them accordingly.

The convention is to leave ValidTo as NA when the entry is valid as of the last update. That
is, at any time in the future unless more information is provided we assume it is valid.

There are several considerations:

\itemize{
\item Rows in common have an updated ValidTo. If the ValidTo is NA, it is kept as such. If the
ValidTo has a time less than as_of, it is updated to as_of.
\item Rows not in the new table have a ValidTo set to as_of.
\item Rows in the new table, but not in the old table, have a ValidFrom
set to as_of. The ValidTo is set to NA.
}
}
\examples{
\dontrun{
vibble::add_snapshot(vibble::vibble(iris, as_of="2022-01-01"), iris[1:10,], as_of
}
}
