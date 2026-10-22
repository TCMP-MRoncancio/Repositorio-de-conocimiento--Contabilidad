# Bonos en Kondor+: estructura, nuevos ejemplos y equivalencias (video 06)

El video 06 (Training Bonos y Repos, 25/06/2026) muestra cómo se define un bono en Kondor+, dos nuevos ejemplos de Bond Deal, la nomenclatura IFRS 9 de las carteras y las tablas de la base de datos de Kondor.

## Estructura de un bono (datos estáticos)

- **Identificación:** Bond (código y nombre), Fixed Income Type (Bond), ISIN/CUSIP Code, Market (Domestic), Type (Secondary), Financial Center, Issuer, City Guarantor, Download Key, Data Provider.
- **Monedas:** Issue Currency, Redemption Currency, Coupon Currency.
- **Amounts:** Face Value (nominal unitario), Issue Price, Issue Amount, No. of Bonds Issued, Redemption Value.
- **Dates:** Issue Date, First Coupon Date, Roll, Settlement Date, Maturity Date, Payoff Update, Perpetual.
- **Flujos:** tabla con Flow Type, Principal Amount, Principal Factor, Start Date, End Date, Payment Date, Days, Cash Flow y Rate, con su base de interés.

**Ejemplo GOVTBDO 1 30092033 (gobierno de Barbados, BBD):**

- Nominal unitario 0,01 BBD; emisión de 183.861.629 BBD; 18.386.162.900 bonos (183.861.629 ÷ 0,01).
- Emitido el 01/10/2018, primer cupón el 31/12/2018, vence el 30/09/2033.
- Cupón trimestral en base ACT/365, con 104 flujos que incluyen amortizaciones de capital.
- Tasa escalonada: 1% hasta septiembre de 2021 y 2,5% desde octubre de 2021; las tasas posteriores no se alcanzan a leer.
- Comprobación de un flujo: 0,01 × 1% × 91/365 = 0,000024932; y 0,01 × 2,5% × 92/365 = 0,000063014.

## Nuevos ejemplos de Bond Deal

| Campo | Bono Barbados (diapositiva) | TES 2033 (demo, Helm Bank) |
| --- | --- | --- |
| Bono | TBBD30092033 – GOVTBDO 1 30092033 | TFIT11090233 – TES FIXED RATE 09-02-2033 |
| Folder | 011TRLSIAC – 011 TRE RLCP SIRR AMORT-COST | BK_DPV_MON – BANKING DPV MONEX |
| Contraparte | GOVERNMENT OF BARBADOS | 120379 – CLIENTE JURIDICO |
| Operación | Compra, D+N | Compra y luego venta, D+N |
| Fechas | Negociación, valor y pago 01/10/2018 | Negociación 25/06/2026, valor 26/06/2026 |
| Face Amount | 606.808.827 BBD | 800.000.000 COP |
| Quantity | 60.680.882.700 | 1.000 |
| Price | 80,896988 | 92,694 |
| Yield | 5,219420921% | 15,000% |
| Accrued | 0 (se negoció el día de emisión) | 4,973 |
| Gross Amount | 490.890.063,96 | 781.336.000 |
| Clearing | DEFAULT | DCV – Depósito Central de Valores |

**Comprobaciones:**

- Barbados: 606.808.827 × 80,896988 / 100 = 490.890.063,96.
- TES 2033: 800.000.000 × (92,694 + 4,973) / 100 = 781.336.000. Del 09/02/2026 al 26/06/2026 van 137 días; 13,25 × 137/365 = 4,973, lo que indica un cupón anual de 13,25% (inferido; no aparece en pantalla).
- El TES 2033 cotiza con descuento (92,694) porque su rendimiento (15%) supera el cupón (13,25%). Es el caso contrario al TES 10% a 105, que rendía 6,93%.
- Un cálculo propio con capitalización anual al 15% da ≈ 92,74; la diferencia con Kondor se explica por la convención de rendimiento que aplica a TES.

## Quantity y nominal unitario

Quantity = Face Amount ÷ nominal unitario del bono (Face Value). En Barbados: 606.808.827 ÷ 0,01 = 60.680.882.700. El nominal unitario depende de cómo esté parametrizado cada bono en cada entorno: en la base hay casos de 1.000.000 PEN = 1.000 unidades (Perú), 10.000 COP = 10.000 unidades (TES 2024) y 800.000.000 COP = 1.000 unidades (TES 2033).

## Equivalencia de carteras (IAS 39 e IFRS 9)

| Nombre en videos 04 y 05 | Nombre en folders del video 06 (IFRS 9) | Valoración |
| --- | --- | --- |
| Trading (negociables) | FVPL | Valor razonable con cambios en resultados |
| AFS (disponibles para la venta) | FVOCI | Valor razonable con cambios en patrimonio (ORI) |
| HTM (al vencimiento) | AMORT-COST | Costo amortizado a la TIR de compra |

Folders vistos: 011 CIB CIBP BB-ISL AMORT-COST, FVOCI y FVPL; 011 CIB CIBP GENERAL AMORT-COST, FVOCI y FVPL; 011 TRE RLCP SIRR AMORT-COST; 011 TRE RLCP LIQ-LAD FVOCI. *Contexto general:* la equivalencia es aproximada; en IFRS 9 la clasificación depende del modelo de negocio y de las características de los flujos del título.

## Tablas de Kondor+ (base KplusLocal)

Se consultaron con SqlDbx en el servidor KONDOR_AWS_QA01:

```sql
SELECT * FROM KplusLocal..Bonds
SELECT * FROM KplusLocal..BondsSchedule WHERE Bonds_Id = 114553
SELECT * FROM KplusLocal..BondsDeals
```

| Tabla | Contenido | Columnas vistas |
| --- | --- | --- |
| Bonds | Datos estáticos del bono | Cpty_Id_Issuer, Cpty_Id_Guarantee, FirstCouponDate, FaceValue, RedemptionValue, IssueDate, IssueAmount, SettlementDate, NoBondsIssued, Indexation, FloatingRates_Id, ResetLag, AccruedFormula, AccruedDateCalc, YieldFormula, YieldBasis, DrawingPercentage, Category, EndOfMonthAdherence, PriceRoundingConv, PriceRoundingType, YieldRoundingConv, Collateral, ProductType_Id, InflatCurves_Id, MarketDataSets_Id |
| BondsSchedule | Calendario de flujos | Bonds_Id, ScheduleLeg, Used, StartDate, EndDate, PaymentDate, FixingDate, ExDividendDate, CashFlowType (I = interés), PeriodType |
| BondsDeals | Operaciones de bonos | BondsDeals_Id, CaptureDate, TradeDate, Users_Id, Users_Id_Last, Folders_Id, Sellers_Id, Purposes_Id, TypeOfEvent (N, M), BlockNumber, Comments, DealType (B = compra, S = venta), Bonds_Id, Quantity, FaceAmount |

Las tres tablas se relacionan por Bonds_Id. Que TypeOfEvent N signifique nuevo y M modificación es una inferencia por los valores vistos.

## Bond Deals Custom Window

Ventana adicional del Bond Deal en Helm Bank, con las secciones Import Curves; Inventario (Bono Origen, Evento, Face Amount, botones Cargar y Borrar, y una grilla con BondsDeals_Id, FaceAmount, Amount_Evento, Disponible y Total); Backoffice back2.x y CBYDEAL back2.x.

## Entornos vistos

- **Helm Bank (Colombia):** jerarquía D_REGION \ D_ENTITY \ HELM_BANK \ RENTAFIJA. Acceso por Amazon WorkSpaces y MobaXterm al servidor kplus, y luego Kondor+ Deal Manager.
- **CIBC Caribbean (CIBCC):** jerarquía CIBCC \ CIBCC \ 011/BAR \ 011-TRE-RL, sede Bridgetown (Barbados). Acceso por Windows App (FusionKondor CIBCC DEV y PROD).