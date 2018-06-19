'use strict'

const logger = require('pino')()
const _ = require('lodash')

const ERROR_MESSAGE = 'There is a problem with the payments platform'

function response (req, res, template, data) {
  return res.render(template, data)
}

function errorResponse (req, res, msg = ERROR_MESSAGE, status = 500, heading = 'Sorry, we’re experiencing technical problems', setReturnUrl = false) {
  logger.error(`[${req.correlationId}] ${status} An error has occurred. Rendering error view -`, {errorMessage: msg})
  res.setHeader('Content-Type', 'text/html')
  res.status(status)
  const returnUrl = setReturnUrl && _.get(res, 'locals.mandate.returnUrl')
  let options = {
    'message': msg,
    'heading': heading
  }

  if (returnUrl) {
    options.returnUrl = returnUrl
  }

  res.render('common/templates/error', options)
}

function renderPaymentCompletedSummary (req, res, params) {
  res.setHeader('Content-Type', 'text/html')
  res.status(200)
  res.render('common/templates/payment_completed_summary', params)
}

module.exports = {
  response: response,
  renderErrorView: errorResponse,
  renderPaymentCompletedSummary: renderPaymentCompletedSummary
}
