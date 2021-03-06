% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/save_locally.R
\name{fn_save_locally}
\alias{fn_save_locally}
\title{Return a javascript function to save data locally}
\usage{
fn_save_locally()
}
\value{
A javascript function to save data locally
}
\description{
Return a javascript function to save data locally
}
\details{
The purpose of the \code{fn_save_locally()} is to return a
javascript function that, when called from within the jsPsych experiment,
will write the data to a CSV file on the local machine (in the data folder
associated with the experiment). The intention is that when an experiment is
to be deployed locally (i.e., using the \code{\link{run_locally}()} function
to run the experiment using an R server on the local machine), the
\code{fn_save_locally()} function provides the mechanism for saving the data.
If the goal is simply to save the data set at the end of the experiment, the
easiest way to do this is when building the experiment using
\code{\link{build_experiment}()}. Specifically, the method for doing this is
to include the argument \code{on_finish = fn_save_locally()} as part of the
call to \code{\link{build_experiment}()}.
}
\seealso{
\code{\link{run_locally}}, \code{\link{build_experiment}}
}
