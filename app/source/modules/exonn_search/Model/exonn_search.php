<?php

use OxidEsales\Eshop\Application\Model\ArticleList;
use \OxidEsales\Eshop\Application\Model\Article;
use OxidEsales\Eshop\Core\Registry;


class exonn_search extends exonn_search_parent
{
    protected function generateSqlByName(string $searchRequestData, array $sort = []): array
    {
        $oArticle = oxNew(Article::class);
        $tableName = $oArticle->getViewName();
        $selectFields = $oArticle->getSelectFields();

        $query = <<<SQL
SELECT $selectFields
FROM $tableName
WHERE oxissearch = 1
  AND OXACTIVE = 1
  AND OXHIDDEN = 0
  AND (exonn_unique_article_id IS NOT NULL OR OXSEARCHKEYS <> '')
  AND ( oxstockflag != 2 OR ( oxstock + oxvarstock ) > 0)
  AND  (oxtitle LIKE :searchName
    OR  oxshORtdesc LIKE :searchName
    OR  oxsearchkeys LIKE :searchName
    OR  oxean LIKE :searchName
    OR  oetags LIKE :searchName
    OR  oxartnum = :artNum)
SQL;

        if ($sort) {
            $query .= 'ORDER BY '. implode(' ', $sort);
        }
        $parameters = [
            'searchName' => "%$searchRequestData%",
            'artNum' => "$searchRequestData",
        ];

        return [$query, $parameters];
    }

    /**
     * @throws \OxidEsales\Eshop\Core\Exception\DatabaseConnectionException
     */
    public function searchArticles(string $searchRequestData, array $sort): ?ArticleList
    {
        $articleList = $this->getLimitedArticleList();

        $start_2 = microtime(true);
        [$query, $parameters] = $this->generateSqlByName($searchRequestData, $sort);
        $articleList->selectString($query, $parameters);
        $stop_2 = microtime(true) - $start_2;
        return $articleList;
    }

    protected function getLimitedArticleList(): ArticleList
    {
        $this->iActPage = (int) Registry::getRequest()->getRequestParameter('pgNr');
        $this->iActPage = ($this->iActPage < 0) ? 0 : $this->iActPage;

        $iNrofCatArticles = $this->getConfig()->getConfigParam('iNrofCatArticles');
        $iNrofCatArticles = $iNrofCatArticles ?: 10;

        /** @var ArticleList $articleList */
        $articleList = oxNew(ArticleList::class);
        $articleList->setSqlLimit($iNrofCatArticles * $this->iActPage, $iNrofCatArticles);

        return $articleList;
    }


}