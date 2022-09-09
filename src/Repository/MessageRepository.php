<?php

namespace App\Repository;

use App\Entity\Message;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\ORM\Tools\Pagination\Paginator;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Message|null find($id, $lockMode = null, $lockVersion = null)
 * @method Message|null findOneBy(array $criteria, array $orderBy = null)
 * @method Message[]    findAll()
 * @method Message[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class MessageRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Message::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(Message $entity, bool $flush = true): void
    {
        $this->_em->persist($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function remove(Message $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    /**
     * @return Message[] Returns an array of Trick objects
     */

    public function findByPage($value, $offset, $trick)
    {
        return $this->createQueryBuilder('m')
            ->where('m.trick = :trick')->setParameter('trick', $trick)
            ->setMaxResults($value)
            ->setFirstResult($offset)
            ->getQuery()
            ->getResult()
            ;
    }
    private function getMessageQueryBuilder($trick){
        // Select the orders and their packages
        $queryBuilder = $this->createQueryBuilder('m');

        $queryBuilder->where('m.trick = :trick')
            ->orderBy('m.createAt', 'DESC')
            ->setParameter('trick', $trick);

        //Return the QueryBuilder
        return $queryBuilder;
    }

    /**
     * Retrieve the list of active orders with all their actives packages
     * @param $page
     * @param $trick
     * @return Paginator
     */
    public function getMessages($page, $trick){
        $pageSize = 5;
        $firstResult = ($page - 1) * $pageSize;

        $queryBuilder = $this->getMessageQueryBuilder($trick);

        // Set the returned page
        $queryBuilder->setFirstResult($firstResult);
        $queryBuilder->setMaxResults($pageSize);

        // Generate the Query
        $query = $queryBuilder->getQuery();

        // Generate the Paginator
        return new Paginator($query, true);
    }

    // /**
    //  * @return Message[] Returns an array of Message objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('m')
            ->andWhere('m.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('m.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?Message
    {
        return $this->createQueryBuilder('m')
            ->andWhere('m.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
