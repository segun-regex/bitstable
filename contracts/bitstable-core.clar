;; Bitcoin-Backed Stablecoin System

;; Summary
;; This smart contract implements a decentralized stablecoin system that is backed by Bitcoin collateral. 
;; Users can create vaults, deposit Bitcoin as collateral, and mint stablecoins against that collateral. 
;; The system ensures stability through various parameters and allows for liquidation if collateral ratios fall below a certain threshold.

;; Description
;; The contract defines constants for various error codes and limits, such as maximum and minimum prices, collateral ratios, and fees. 
;; It also defines data variables to store the current state of the system, including the minimum collateral ratio, liquidation ratio, stability fee, and the latest BTC/USD price.
;; The contract includes several public functions for initializing the system, creating vaults, minting stablecoins, repaying debt, withdrawing collateral, and liquidating vaults. 
;; It also includes functions for updating the BTC/USD price, setting governance parameters, and managing authorized liquidators and oracles.
;; Emergency functions allow the contract owner to trigger an emergency shutdown, and read-only functions provide information about the current state of the system and individual vaults.

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-insufficient-collateral (err u101))
(define-constant err-below-mcr (err u102))
(define-constant err-already-initialized (err u103))
(define-constant err-not-initialized (err u104))
(define-constant err-low-balance (err u105))
(define-constant err-invalid-price (err u106))
(define-constant err-emergency-shutdown (err u107))
(define-constant err-invalid-parameter (err u108))
(define-constant maximum-price u1000000000) ;; Maximum allowed price (sanity check)
(define-constant minimum-price u1) ;; Minimum allowed price
(define-constant maximum-ratio u1000) ;; Maximum collateral ratio (1000%)
(define-constant minimum-ratio u101) ;; Minimum collateral ratio (101%)
(define-constant maximum-fee u100) ;; Maximum stability fee (100%)

;; Data Variables
(define-data-var minimum-collateral-ratio uint u150) ;; 150% collateralization ratio
(define-data-var liquidation-ratio uint u120) ;; 120% liquidation threshold
(define-data-var stability-fee uint u2) ;; 2% annual stability fee
(define-data-var initialized bool false)
(define-data-var emergency-shutdown bool false)
(define-data-var last-price uint u0) ;; Latest BTC/USD price
(define-data-var price-valid bool false)
(define-data-var governance-token principal 'SP000000000000000000002Q6VF78.governance-token)

;; Storage
(define-map vaults
    principal
    {
        collateral: uint,
        debt: uint,
        last-fee-timestamp: uint
    }
)

(define-map liquidators principal bool)
(define-map price-oracles principal bool)

;; Validation Functions
(define-private (is-valid-price (price uint))
    ;; Check if the price is within the allowed range
    (and 
        (>= price minimum-price)
        (<= price maximum-price)
    )
)

(define-private (is-valid-ratio (ratio uint))
    ;; Check if the ratio is within the allowed range
    (and 
        (>= ratio minimum-ratio)
        (<= ratio maximum-ratio)
    )
)

(define-private (is-valid-fee (fee uint))
    ;; Check if the fee is within the allowed range
    (<= fee maximum-fee)
)