<?php

namespace App\Controller;

use App\Entity\Media;
use App\Entity\Message;
use App\Entity\Trick;
use App\Entity\Video;
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
    public function index(TrickRepository $trickRepository, $page): Response
    {
        $user = $this->getUser();
        $tricks = $trickRepository;
        $totalTricks = count($tricks->findAll());
        $trickPerPage = 9;
        $nbPage = ceil($totalTricks / $trickPerPage);
//        dd($nbPage);
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

            if (isset($_FILES['trick']['name']['media']))
            {

                // On récupère les images transmises
                $images = $form->get('media')->getData();

                // On boucle sur les images
                foreach($images as $image){
                    $extension = explode(".", $image->getClientOriginalName());
//                    dd($extension);
                    $filename = uniqid().'.'.end($extension);
                    move_uploaded_file($image, dirname(__DIR__).'/../public/images/'.$filename);

                    // On crée l'image dans la base de données
                    $img = new Media();
                    $img->setName($filename);
                    $trick->addMedium($img);
                }
            }
            if (isset($_FILES['trick']['name']['banner']) && $_FILES['trick']['name']['banner'] != '') {
                $extension = explode(".", $_FILES['trick']['name']['banner']);
                $filename = uniqid().'.'.end($extension);
                move_uploaded_file($_FILES['trick']['tmp_name']['banner'], dirname(__DIR__).'/../public/images/'.$filename);
                $trick->setBanner($filename);
            }
            if ($form->get('videos')->getData() !== null)
            {
                foreach (explode(',', $form->get('videos')->getData()) as $videoUrl)
                {
                    $video = new Video();
                    $video->setUrl($videoUrl);
                    $video->setTrick($trick);
                    $videoRepository->add($video);
                }
            }
            $trick->setAuthor($user);
            $trick->setCreatedAt($now);
            $trick->setUpdatedAt($now);

            $trickRepository->add($trick);
            return $this->redirectToRoute('app_trick_index', ['page' => 1], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('trick/new.html.twig', [
            'trick' => $trick,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}/page{page}", name="app_trick_show", methods={"GET", "POST"})
     */
    public function show(Trick $trick, MessageRepository $messageRepository, Request $request, UserRepository $userRepository, $page): Response
    {
        $messageRepository->findByTrick($trick);
        $user = $this->getUser();

        $message = new Message();
        $message->setCreateAt(new DateTimeImmutable('now'));
        $message->setIsActive = true;
        $message->setAuthor($user);
        $message->setTrick($trick);

        $messages = $messageRepository->findByTrick($trick);
        $totalMessage = count($messages);
        $messagePerPage = 10;
        $nbPage = ceil($totalMessage / $messagePerPage);
//        dd($nbPage);
        $offset = ($page - 1) * $messagePerPage;
        $messages = $messageRepository->findByPage($messagePerPage, $offset, $trick);

        if ($request->isMethod('POST')) {
//            dd($request);
            $message->setContent($request->get('content'));
            $messageRepository->add($message);
        }
        return $this->render('trick/show.html.twig', [
            'trick' => $trick,
            'user' => $user,
            'page' => $page,
            'messages' => $messages,
            'nbPages' => $nbPage
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_trick_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Trick $trick, TrickRepository $trickRepository): Response
    {
        $form = $this->createForm(TrickType::class, $trick);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
//            dd($_FILES);
            if (isset($_FILES['trick']['name']['banner']) && $_FILES['trick']['name']['banner'] != '') {
                $extension = explode(".", $_FILES['trick']['name']['banner']);
                $filename = uniqid().'.'.end($extension);
                move_uploaded_file($_FILES['trick']['tmp_name']['banner'], dirname(__DIR__).'/../public/images/'.$filename);
                $trick->setBanner($filename);
            }
            $trick->setUpdatedAt(new DateTimeImmutable('now'));
            $trickRepository->add($trick);
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
        if ($this->isCsrfTokenValid('delete'.$trick->getId(), $request->request->get('_token'))) {
            $trickRepository->remove($trick);
        }

        return $this->redirectToRoute('app_trick_index', ['page' => 1], Response::HTTP_SEE_OTHER);
    }
}
