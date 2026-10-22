# Swaps (IRS y CCS)

Un swap es un acuerdo en el que una parte paga periódicamente una serie de flujos a cambio de recibir otra serie de la contraparte; normalmente son intereses sobre un nominal. Puede liquidarse Delivery (se intercambian los flujos completos en cada moneda) o Non Delivery (solo se paga el neto). En Kondor+ se captura como IRS/CIRS Deal, con una pata Receiving (verde) y una Paying (roja).

- **IRS:** misma moneda en ambas patas, típicamente fija contra flotante.
- **CCS (Cross Currency Swap):** cada pata en una moneda distinta.

| Ejemplo | Contraparte | Pata que se recibe | Pata que se paga | Plazo |
| --- | --- | --- | --- | --- |
| IRS Non Delivery CLP (deal 21307) | Banco del Estado de Chile | CLP 168.000 MM flotante 1 × CLPSTSWON (ICP), fixing diario | CLP 168.000 MM fija 1,70% | 04/12/2019 → 04/03/2020 |
| CCS Delivery USD/COP (deal 24557) | TCM Partners | USD 120.000 fija 2,00% | COP 468.000.000 flotante 1 × IBRON, tasa de cambio 3.900 | 09/01/2021 → 14/01/2021 |
| CCS demo video 03 | Agropecuaria Aliar | USD 5.000.000 fija 9,00% | COP flotante sobre índice overnight | 05/10/2022 → 05/10/2027, base ACT/360 |

## Contabilidad del IRS por fase (deal 21307)

1. **Trade Date – Trade Event:** el nominal va a cuentas de orden y responsabilidad (SWP_Orden/Respon Loan TE y Depo TE) por CLP 168.000.000.000 en cada pata.
2. **Revaluación diaria (TradeDate … BeginDate-1 y luego hasta MaturityDate-1):** se registra el MtM de cada pata (MTM Loan ≈ 168.447,8 MM; MTM Depo ≈ 168.433,9 MM). La diferencia, CLP 13.990.073, va a SWP Utilidad. Cada día se reversa la valoración anterior (Rev MTM) y se registra la nueva, junto con los intereses causados.
3. **Maturity Date:** se reversan las cuentas de orden del nocional; el CashFlow registra el interés de la pata fija pagada (CLP 721.933.333) y el de la flotante recibida (CLP 743.166.667). El neto, CLP 21.233.334, es la ganancia.
4. **Payment (05/03/2020):** se liquida solo el neto de CLP 21.233.334 (Non Delivery).

Comprobación: 168.000 MM × 1,70% × 91/360 = 721.933.333, así que la pata fija usa base ACT/360.

## Contabilidad del CCS por fase (deal 24557)

1. **Trade Event:** nominales en cuentas de orden: USD 120.000 (COP 410.493.600 a 3.420,78) y COP 468.000.000.
2. **Revaluación:** valoración del derecho (COP 475.333.377,28) y de la obligación (COP 467.938.780,98); la diferencia, COP 7.394.596,30, va a PyG.
3. **Reclasificación y liquidación de flujos:** al pagarse cada flujo, las posiciones activas y pasivas se reclasifican a PyG (SWP_ReclaPosA_P) y se cancelan nominales; como es Delivery, se pagan y reciben los montos brutos en cada moneda.
