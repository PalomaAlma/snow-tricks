<?php

namespace App\Controller;

use App\Entity\Media;
use App\Entity\Message;
use App\Entity\Trick;
use App\Entity\Video;
use App\Form\MessageType;
use App\Form\TrickType;
use App\Repository\MessageRepository;
use App\Repository\TrickRepository;
use App\Repository\UserRepository;
use App\Repository\VideoRepository;
use DateTimeImmutable;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/trick")
 */
class TrickController extends AbstractController
{
    /**
     * @Route("/", name="homepage", methods={"GET"})
     * @Route("/page{page?1}", name="app_trick_index", methods={"GET"})
     */
    public function index(TrickRepository $trickRepository, int $page): Response
    {
        $user = $this->getUser();
        $tricks = $trickRepository;

        // Pagination
        $totalTricks = count($tricks->findAll());
        $trickPerPage = 9;
        $nbPage = ceil($totalTricks / $trickPerPage);
        $offset = ($page - 1) * $trickPerPage;
        $tricks = $tricks->findByPage($trickPerPage, $offset);

        return $this->render('trick/index.html.twig', [
            'tricks' => $tricks,
            'page' => $page,
            'nbPages' => $nbPage,
            'user' => $user
        ]);
    }

    /**
     * @Route("/new", name="app_trick_new", methods={"GET", "POST"})
     */
    public function new(Request $request, TrickRepository $trickRepository, VideoRepository $videoRepository): Response
    {
        $now = new \DateTimeImmutable('now');
        $user = $this->getUser();
        $trick = new Trick();
        $form = $this->createForm(TrickType::class, $trick);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            // Récupère les images
            if ($form->get('media')->getData() !== null)
            {
                $images = $form->get('media')->getData();

                foreach($images as $image){
                    $extension = explode(".", $image->getClientOriginalName());
                    $filename = uniqid().'.'.end($extension);
                    move_uploaded_file($image, dirname(__DIR__).'/../public/images/'.$filename);
                    $img = new Media();
                    $img->setName($filename);
                    $trick->addMedium($img);
                }
            }

            // Récupère la bannière
            if ($form->get('banner')->getData() !== null && $form->get('banner')->getData() != '') {
                $extension = explode(".", $form->get('banner')->getData()->getClientOriginalName());
                $filename = uniqid().'.'.end($extension);
                move_uploaded_file($form->get('banner')->getData(), dirname(__DIR__).'/../public/images/'.$filename);
                $trick->setBanner($filename);
            }

            // Récupère les vidéos
            if ($form->get('videos')->getData() !== null)
            {
                foreach (explode(',', $form->get('videos')->getData()) as $videoUrl)
                {
                    // Récupère la dernière chaîne de caractère du lien Youtube
                    $array = explode('/', $videoUrl);
                    $videoCode = array_pop($array);

                    $video = new Video();
                    $video->setUrl($videoCode);
                    $video->setTrick($trick);
                    $videoRepository->add($video);
                }
            }

            $trick->setAuthor($user);
            $trick->setCreatedAt($now);
            $trick->setUpdatedAt($now);

            $trickRepository->add($trick);
            $this->addFlash('success', 'Votre Trick a bien été ajouté.');

            return $this->redirectToRoute('app_trick_index', ['page' => 1], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('trick/new.html.twig', [
            'trick' => $trick,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{slug}_{id}/page{page}", name="app_trick_show", methods={"GET", "POST"})
     */
    public function show(Trick $trick, MessageRepository $messageRepository, Request $request, UserRepository $userRepository, int $page): Response
    {
        $messageRepository->findByTrick($trick);
        $user = $this->getUser();
        $message = new Message();

        //Pagination
        $paginatedResult = $messageRepository->getMessages($page, $trick);
        $totalMessage = count($paginatedResult);
        $totalPage = ceil($totalMessage/5);

        $form = $this->createForm(MessageType::class, $message);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $message->setCreateAt(new DateTimeImmutable('now'));
            $message->setIsActive = true;
            $message->setAuthor($user);
            $message->setTrick($trick);

            $messageRepository->add($message);

            $this->addFlash('success', 'Votre commentaire à bien été posté');
        }

        return $this->renderForm('trick/show.html.twig', [
            'trick' => $trick,
            'user' => $user,
            'page' => $page,
            'messages' => $paginatedResult,
            'totalMessage' => $totalMessage,
            'totalPage' => $totalPage,
            'form' => $form
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_trick_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Trick $trick, TrickRepository $trickRepository, VideoRepository $videoRepository): Response
    {
        $form = $this->createForm(TrickType::class, $trick);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            // Récupère les images
            if ($form->get('media')->getData() !== null)
            {
                $images = $form->get('media')->getData();

                foreach($images as $image){
                    $extension = explode(".", $image->getClientOriginalName());
                    $filename = uniqid().'.'.end($extension);
                    move_uploaded_file($image, dirname(__DIR__).'/../public/images/'.$filename);
                    $img = new Media();
                    $img->setName($filename);
                    $trick->addMedium($img);
                }
            }

            // Récupère la bannière
            if ($form->get('banner')->getData() !== null && $form->get('banner')->getData() != '') {
                $extension = explode(".", $form->get('banner')->getData()->getClientOriginalName());
                $filename = uniqid().'.'.end($extension);
                move_uploaded_file($form->get('banner')->getData(), dirname(__DIR__).'/../public/images/'.$filename);
                $trick->setBanner($filename);
            }

            // Récupère les vidéos
            if ($form->get('videos')->getData() !== null)
            {
                foreach (explode(',', $form->get('videos')->getData()) as $videoUrl)
                {
                    // Récupère la dernière chaîne de caractère du lien Youtube
                    $array = explode('/', $videoUrl);
                    $videoCode = array_pop($array);

                    $video = new Video();
                    $video->setUrl($videoCode);
                    $video->setTrick($trick);
                    $videoRepository->add($video);
                }
            }

            $trick->setUpdatedAt(new DateTimeImmutable('now'));
            $trickRepository->add($trick);

            $this->addFlash('success', 'Votre Trick a bien été mis à jour.');

            return $this->redirectToRoute('app_trick_index', ['page' => 1], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('trick/edit.html.twig', [
            'trick' => $trick,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_trick_delete", methods={"POST"})
     */
    public function delete(Request $request, Trick $trick, TrickRepository $trickRepository): Response
    {
        $delete = 'delete';

        if ($trick->getAuthor() === $this->getUser())
        {
            if ($this->isCsrfTokenValid($delete.$trick->getId(), $request->request->get('_token'))) {
                $trickRepository->remove($trick);
                $this->addFlash('success', 'Votre Trick a bien été supprimé.');
            }
        }

        return $this->redirectToRoute('app_trick_index', ['page' => 1], Response::HTTP_SEE_OTHER);
    }
}
