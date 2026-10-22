# Repos (operaciones de reporto)

Un repo es una operación de financiamiento con garantía: una parte entrega un título y recibe efectivo, con el compromiso de revertir la operación en una fecha pactada pagando un interés (*contexto general*). En Kondor+ se captura en el ticket **Repo Deal**, con dos patas: **Cash** (efectivo) y **Security** (título). Fuente: video 06, Training Bonos y Repos (25/06/2026).

## Tipos de operación (campo Deal Type)

| Deal Type | Qué hace quien captura (*contexto general*) |
| --- | --- |
| Repo | Entrega el título y recibe efectivo: toma fondos |
| Reverse Repo | Entrega efectivo y recibe el título: presta fondos |
| Security Lending | Presta un título. En la demo pidió la licencia "K+ Repo Securities Lending Extended" |
| Security Borrowing | Toma prestado un título |
| Sell/Buy Back | Venta hoy y recompra futura, documentadas como dos operaciones |
| Buy/Sell Back | Compra hoy y reventa futura, documentadas como dos operaciones |

Junto al Deal Type se elige **Single** (un solo título).

## Colores del ticket

En Kondor+ el verde marca lo que se recibe y el rojo lo que se entrega. En un Repo la pata Cash es verde y la Security roja; en un Reverse Repo, al revés. Es la misma lógica del IRS/CIRS Deal (Receiving verde, Paying rojo) y del Bond Deal (barra roja en compra, verde en venta).

## Campos del Repo Deal

- **Main Body:** Folder, Counterparty, Deal Type, Single, Instrument, Deal Currency.
- **Dates:** atajos Intraday, S/N, O/N y T/N; Trade Date, Value Date, Maturity Date, botón Open (repo sin vencimiento fijo), Call Notice, Payoff Update, Extendable, Reset Lag, Reset Date, Extension Lag, Extended Maturity Date, Original Maturity Date.
- **Cash, Indexation:** Payment Type (Rate), Fixed o Floating (con Floating se elige un índice de una lista), Fixed Rate, Frequency (Interest at Maturity), Fee, Cl. Rate, Cl. Margin (pb), MR Liability.
- **Cash, Interest Methods:** Interest (Simple Interest), Compound Frequency, Margin Method (Weighted), First Cpn Date, Coupon Rates, Min. Fee.
- **Security Details:** tipo (Bond), código y nombre del título, ISIN Code, botones Info y Check Position, Clearing, Bond Sample, Face Amount, Quantity, Price, Accrued, Dirty Price, Yield, Gross Amount, Weighted Amount, Fwd. Price (Spot Origin), Forward Yield, Factor, Current Factor, Coupon To, Reinv. Coupon Rate, Haircut Method, Haircut, Used, Compute Qty, Face Value (Current u Original).
- **Totales:** Global Amount, Forward Amount y botón Compute.

## Ejemplos

| Campo | Reverse Repo (diapositiva) | Repo (demo en vivo) |
| --- | --- | --- |
| Folder | 051TNFMM – 051 TRE NFCP MONEY MARKET | 011TRLLLFO – 011 TRE RLCP LIQ-LAD FVOCI |
| Contraparte | BOFA SECURITIES INC | BANK OF NOVA SCOTIA BAHAMAS |
| Moneda | USD | BSD |
| Fechas | Negociación y valor 04/03/2026, vencimiento 05/03/2026 (1 día) | Negociación y valor 25/06/2026, vencimiento abierto (Open) |
| Tasa del efectivo | 3,55% fija, interés al vencimiento, simple | 4,00% fija, interés al vencimiento, simple |
| Título | US91282CGQ87 – USTREAS 4 28022030 | BST800007483 – GOVTBHS 0 11082026 (cero cupón) |
| Face Amount | 90.000.000 | 500.000 |
| Quantity | 900.000 | 500.000 |
| Price / Dirty Price | 100 / 100 | 60 / 60 |
| Gross Amount | 90.000.000 | 300.000 |
| Weighted Amount | 181.800.000 (no se explica en pantalla) | 300.000 |
| Otros | Fwd. Price 99,955066590; Yield 4,05211683; Forward Yield 4,05240253 | Coupon To: Seller; Haircut Method 100/HC; Haircut 100 |

**Cálculos:**

- Gross Amount = Face Amount × Dirty Price / 100: 90.000.000 × 100% = 90.000.000; 500.000 × 60% = 300.000.
- Con haircut 100 y método 100/HC, el efectivo es igual al valor del colateral (300.000 = 300.000). *Contexto general:* con 100/HC, efectivo = valor del colateral × 100 ÷ HC; un HC mayor a 100 reduce el efectivo.
- Interés del reverse repo (cálculo propio, base ACT/360 supuesta porque el ticket no la muestra): 90.000.000 × 3,55% × 1/360 = USD 8.875. La recompra sería ≈ USD 90.008.875.

## Datos a tomar con cuidado

- En el repo de la demo, el precio 60 y el yield de 5.182,85% son valores de prueba, no referencia de mercado.
- En la diapositiva del reverse repo, el Accrued aparece en 0 aunque el bono paga cupón del 4%.
- La contabilidad de repos no se mostró en el video y no está en esta base.