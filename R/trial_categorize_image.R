#' Specify a categorization trial with an image stimulus
#'
#' @description The \code{trial_categorize_image} function is used to display
#' an image stimulus, collect a categorization response with the
#' keyboard, and provide feedback.
#'
#' @param stimulus The path to the image file to be displayed.
#' @param key_answer The numeric key code indicating the correct response
#' @param choices A character vector of keycodes (either numeric values or the characters themselves). Alternatively, respond_any_key() and respond_no_key() can be used
#' @param text_answer A label associated with the correct answer
#' @param correct_text Text to display when correct answer given ('\%ANS\%' substitutes text_answer)
#' @param incorrect_text Text to display when wrong answer given ('\%ANS\%' substitutes text_answer)
#'
#' @param prompt A string (may contain HTML) that will be displayed below the stimulus, intended as a reminder about the actions to take (e.g., which key to press).
#'
#' @param force_correct_button_press If TRUE the correct button must be pressed after feedback in order to advance
#' @param show_stim_with_feedback If TRUE the stimulus image will be displayed as part of the feedback. Otherwise only text is shown
#' @param show_feedback_on_timeout If TRUE the "wrong answer" feedback will be presented on timeout. If FALSE, a timeout message is shown
#' @param timeout_message The message to show on a timeout non-response
#' @param stimulus_duration How long to show the stimulus, in milliseconds. If NULL, then the stimulus will be shown until the subject makes a response
#' @param feedback_duration How long to show the feedback, in milliseconds
#' @param trial_duration How long to wait for a response before ending trial in milliseconds. If NULL, the trial will wait indefinitely. If no response is made before the deadline is reached, the response will be recorded as NULL.
#'
#' @param post_trial_gap  The gap in milliseconds between the current trial and the next trial. If NULL, there will be no gap.
#' @param on_finish A javascript callback function to execute when the trial finishes
#' @param on_load A javascript callback function to execute when the trial begins, before any loading has occurred
#' @param data An object containing additional data to store for the trial
#'
#'
#' @return Functions with a \code{trial_} prefix always return a "trial" object.
#' A trial object is simply a list containing the input arguments, with
#' \code{NULL} elements removed. Logical values in the input (\code{TRUE} and
#' \code{FALSE}) are transformed to character vectors \code{"true"} and \code{"false"}
#' and are specified to be objects of class "json", ensuring that they will be
#' written to file as the javascript logicals, \code{true} and \code{false}.
#'
#' @details The \code{trial_categorize_image} function is used to show an image object on the screen.
#' The subject responds by pressing a key. Feedback indicating the correctness
#' of the response is given.
#'
#'
#' \subsection{Stimulus display}{
#' For trials that display an image, the \code{stimulus} argument is a string that
#' specifies the path to the image file. More precisely, it must specify the path to
#' where the image file will be located at the time the experiment runs. Typically,
#' if an experiment is deployed using the \code{\link{build_experiment}()} function
#' all resource files will be stored in a "resource" folder, and the images will
#' be copied to the "image" subfolder. So if the image to be displayed is a file
#' called "picture.png", the \code{stimulus} path on a Mac or Linux machine would
#' likely be "resource/image/picture.png". Note that this path is specified relative
#' to the location of the primary experiment file "image.html". To make this a little
#' easier, the \code{\link{insert_resource}()} function can be used to construct
#' resource paths automatically. In the example above,
#' \code{stimulus = insert_resource("picture.png")} would suffice.
#' }
#'
#' \subsection{Response mechanism}{
#' For this kind of trial, participants can make a response by pressing a key,
#' and the \code{choices} argument is used to control which keys will register
#' a valid response. The default value \code{choices = \link{respond_any_key}()}
#' is to allow the participant to press any key to register their response.
#' Alternatively it is possible to set \code{choices = \link{respond_no_key}()},
#' which prevents all keys from registering a response: this can be useful if
#' the trial is designed to run for a fixed duration, regardless of what the
#' participant presses.
#'
#' In many situations it is preferable to require the participant to respond
#' using specific keys (e.g., for a binary choice tasks, it may be desirable to
#' require participants to press F for one response or J for the other). This
#' can be achieved in two ways. One possibility is to use a character vector
#' as input (e.g., \code{choices = c("f","j")}). The other is to use the
#' numeric code that specifies the desired key in javascript, which in this
#' case would be \code{choices = c(70, 74)}. To make it a little easier to
#' work with numeric codes, the jaysire package includes the
#' \code{\link{keycode}()} function to make it easier to convert from one format
#' to the other.
#' }
#'
#' \subsection{Feedback}{
#'
#' In a categorisation trial, there is always presumed to be a "correct" response
#' for any given stimulus, and the participant is presented with feedback after
#' the response is given. This feedback can be customised in several ways:
#' \itemize{
#' \item The \code{key_answer} argument specifies the numeric \code{\link{keycode}}
#' that corresponds to the correct response for the current trial.
#' \item The \code{correct_text} and \code{incorrect_text} arguments are used to
#' customise the feedback text that is presented to the participant after a
#' response is given. In both cases, there is a special value \code{"\%ANS\%"} that
#' can be used, and will be substituted with the value of \code{text_answer}.
#' For example if we set \code{text_answer = "WUG"}, we could then set
#' \code{correct_text = "Correct! This is a \%ANS\%"} and
#' \code{incorrect_text = "Wrong. This is a \%ANS\%"}. This functionality can be
#' particularly useful if the values of \code{text_answer} and \code{stimulus}
#' are specified using timeline variables (see \code{\link{insert_variable}()} and
#' \code{\link{tl_add_variables}()}).
#' \item The \code{force_correct_button_press} argument is a logical variable.
#' If set to \code{TRUE} the participant cannot move forward to the next trial
#' until the correct response is given.
#' \item When \code{show_stim_with_feedback = TRUE}, the \code{stimulus} remains
#' on screen while the feedback is presented. If it is set to \code{FALSE} the
#' stimulus is not visible.
#' \item Sometimes a categorisation trial has a deadline, specified by the value
#' of \code{trial_duration}. If a response is not given by that time, the trial
#' ends. Optionally, a feedback screen can be presented whenever this occurs,
#' by setting \code{show_feedback_on_timeout = FALSE}, and the text of this
#' feedback is specified by using the \code{timeout_message} argument.
#' }
#' }
#'
#' \subsection{Other behaviour}{
#'
#' The \code{prompt} argument is used to specify text that remains on screen while
#' the animation displays. The intended use is to remind participants of the
#' valid response keys, but it allows HTML markup to be included and so can be
#' used for more general purposes.
#'
#' Like all functions in the \code{trial_} family it contains four additional
#' arguments:
#'
#' \itemize{
#' \item The \code{post_trial_gap} argument is a numeric value specifying the
#' length of the pause between the current trial ending and the next one
#' beginning. This parameter overrides any default values defined using the
#' \code{\link{build_experiment}} function, and a blank screen is displayed
#' during this gap period.
#'
#' \item The \code{on_load} and \code{on_finish} arguments can be used to
#' specify javascript functions that will execute before the trial begins or
#' after it ends. The javascript code can be written manually and inserted *as*
#' javascript by using the \code{\link{insert_javascript}} function. However,
#' the \code{fn_} family of functions supplies a variety of functions that may
#' be useful in many cases.
#'
#' \item The \code{data} argument can be used to insert custom data values into
#' the jsPsych data storage for this trial
#' }
#' }
#'
#' \subsection{Data}{
#'
#' When this function is called from R it returns the trial object that will
#' later be inserted into the experiment when \code{\link{build_experiment}}
#' is called. However, when the trial runs as part of the experiment it returns
#' values that are recorded in the jsPsych data store and eventually form part
#' of the data set for the experiment.
#'
#'
#' The data recorded by this trial is as follows:
#'
#' \itemize{
#' \item The \code{stimulus} value is the path to the image file.
#' \item The \code{key_press}
#' value indicates which key the subject pressed. The value is the numeric key
#' code corresponding to the subject's response.
#' \item The \code{rt} value is the
#' response time in milliseconds for the subject to make a response. The time is
#' measured from when the stimulus first appears on the screen until the subject's
#' response.
#' \item The \code{correct} value is true if the subject got the correct answer,
#' false otherwise.
#' }
#'
#' In addition, it records default variables that are recorded by all trials:
#'
#' \itemize{
#' \item \code{trial_type} is a string that records the name of the plugin used to run the trial.
#' \item \code{trial_index} is a number that records the index of the current trial across the whole experiment.
#' \item \code{time_elapsed} counts the number of milliseconds since the start of the experiment when the trial ended.
#' \item \code{internal_node_id} is a string identifier for the current "node" in the timeline.
#' }
#' }
#'
#' @seealso There are three types of categorization trial, corresponding to the
#' \code{\link{trial_categorize_animation}},
#' \code{\link{trial_categorize_html}} and
#' \code{\link{trial_categorize_image}} functions.
#'
#' @export
trial_categorize_image <- function(
  stimulus,
  key_answer,
  choices = respond_any_key(),
  text_answer = "",
  correct_text = "Correct",
  incorrect_text = "Wrong",
  prompt = NULL,
  force_correct_button_press = FALSE,
  show_stim_with_feedback = TRUE,
  show_feedback_on_timeout = FALSE,
  timeout_message = "Please respond faster",
  stimulus_duration = NULL,
  feedback_duration = 2000,
  trial_duration = NULL,

  post_trial_gap = 0,  # start universals
  on_finish = NULL,
  on_load = NULL,
  data = NULL
) {
  drop_nulls(
    trial(
      type = "categorize-image",
      stimulus = stimulus,
      key_answer = key_answer,
      choices = choices,
      text_answer = text_answer,
      correct_text = correct_text,
      incorrect_text = incorrect_text,
      prompt = prompt,
      force_correct_button_press = js_logical(force_correct_button_press),
      show_stim_with_feedback = js_logical(show_stim_with_feedback),
      show_feedback_on_timeout = js_logical(show_feedback_on_timeout),
      timeout_message = timeout_message,
      stimulus_duration = stimulus_duration,
      feedback_duration = feedback_duration,
      trial_duration = trial_duration,
      post_trial_gap = post_trial_gap,
      on_finish = on_finish,
      on_load = on_load,
      data = data
    )
  )
}
