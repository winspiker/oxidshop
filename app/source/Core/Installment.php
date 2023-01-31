<?php
declare(strict_types=1);

namespace OxidEsales\EshopCommunity\Core;

use OxidEsales\EshopCommunity\Application\Model\Article;
use OxidEsales\Eshop\Core\Price;

class Installment
{
    private Price $fullPrice;
    private ?Price $firstPayment;
    private ?Price $monthPayment;
    private ?int $paymentMonths;

    public function __construct(Article $article)
    {
        // TODO: Get fullPrice by user group (A, B, C)
        $this->fullPrice = $article->getPrice();
        $this->firstPayment = $article->getFirstPaymant();
        $this->paymentMonths = $article->getPaymentMonths();
        $this->monthPayment = $this->calculateMonthPayment();
    }

    private function calculateMonthPayment(): ?Price
    {
        if (false === $this->isInstallmentActive()) {
            return null;
        }

        $payment = ($this->fullPrice->getPrice() - $this->firstPayment->getPrice()) / $this->paymentMonths;

        return new Price($payment);
    }

    public function isInstallmentActive(): bool
    {
        return ($this->firstPayment->getPrice() !== 0.0) && ($this->paymentMonths !== 0);
    }

    /**
     * @return \OxidEsales\Eshop\Core\Price|null
     */
    public function getFirstPayment(): ?Price
    {
        return $this->firstPayment;
    }

    /**
     * @return \OxidEsales\Eshop\Core\Price|null
     */
    public function getMonthPayment(): ?Price
    {
        return $this->monthPayment;
    }

    /**
     * @return int|null
     */
    public function getPaymentMonths(): ?int
    {
        return $this->paymentMonths;
    }

    /**
     * @return \OxidEsales\Eshop\Core\Price
     */
    public function getFullPrice(): Price
    {
        return $this->fullPrice;
    }
}