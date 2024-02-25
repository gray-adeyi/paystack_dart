# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Nothing is planned yet.

## [0.0.2] - 2024-02-25

### Added

- Image shield icons to readme.
- API Documentation.
- `BulkChargeStatus` an enum for the different states a bulk charge can be.
- Expose API for other clients e.g. `ApplePayClient`, `BulkChargeClient` e.t.c
- Expose exceptions

### Fixed

- Missing query parameters for `BulkChargeClient.charges`

### Changed

- Rename `TransactionSplitClient.createSplit` to `TransactionSplitClient.create`

## [0.0.1] - 2024-02-11

### Added

- ApplePayClient.
- BulkChargeClient.
- ChargeClient.
- CustomerClient.
- DedicatedVirtualAccountClient.
- DisputeClient.
- IntegrationClient.
- MiscellaneousClient.
- PaymentPageClient.
- PaymentRequestClient.
- PlanClient.
- ProductClient.
- RefundClient.
- SettlementClient.
- SubaccountClient.
- SubscriptionClient.
- TerminalClient.
- TransactionClient.
- TransactionSplitClient.
- TransferClient.
- TransferControlClient.
- TransferRecipientClient.
- VerificationClient.
- PaystackClient to exposes all the other clients as bindings.
