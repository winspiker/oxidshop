<?php

class exonnkaufbei_installment
{
    /**
     * Full article price
     *
     * @var float
     */
    private $fullPrice;

    /**
     * First article payment
     *
     * @var float
     */
    private $firstPayment;

    /**
     * Monthly article payment
     *
     * @var float
     */
    private $monthlyPayment;

    /**
     * Number of monthly payments
     *
     * @var int
     */
    private $paymentMonths;

    public function __construct(float $fullPrice, float $firstPayment, int $paymentMonths)
    {
        $this->fullPrice = $fullPrice;
        $this->firstPayment = $firstPayment;
        $this->paymentMonths = $paymentMonths;
        $this->monthlyPayment = $this->calculateMonthlyPayment();
    }


    /**
     * Monthly payment calculation
     *
     * @return float
     */
    private function calculateMonthlyPayment(): float
    {
        return ($this->fullPrice - $this->firstPayment) / (float)$this->paymentMonths;
    }

    /**
     * Get first payment value
     *
     * @return float
     */
    public function getFirstPayment(): float
    {
        return $this->firstPayment;
    }

    /**
     * Get the monthly payment value
     *
     * @return float
     */
    public function getMonthlyPayment(): float
    {
        return $this->monthlyPayment;
    }

    /**
     * Get full price of the article
     *
     * @return float
     */
    public function getFullPrice(): float
    {
        return $this->fullPrice;
    }

    /**
     * Get the number of monthly payments
     *
     * @return int
     */
    public function getPaymentMonths(): int
    {
        return $this->paymentMonths;
    }
}