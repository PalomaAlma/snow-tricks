<?php

namespace App\Controller;

use App\Entity\Message;
use App\Entity\Trick;
use App\Form\TrickType;
use App\Repository\MessageRepository;
use App\Repository\TrickRepository;
use App\Repository\UserRepository;
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
     * @Route("/", name="app_trick_index", methods={"GET"})
     */
    public function index(TrickRepository $trickRepository): Response
    {
        $user = $this->getUser();
        return $this->render('trick/index.html.twig', [
            'tricks' => $trickRepository->findAll(),
            'user' => $user
        ]);
    }

    /**
     * @Route("/new", name="app_trick_new", methods={"GET", "POST"})
     */
    public function new(Request $request, TrickRepository $trickRepository): Response
    {
        $trick = new Trick();
        $form = $this->createForm(TrickType::class, $trick);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            if (isset($_FILES['customer_registration']['name']['picture']) && $_FILES['customer_registration']['name']['picture'] != '') {
                $extension = explode(".", $_FILES['customer_registration']['name']['picture']);
                $filename = uniqid().'.'.end($extension);
                move_uploaded_file($_FILES['customer_registration']['tmp_name']['picture'], dirname(__DIR__).'/../public/uploads/'.$filename);
                $trick->setBanner($filename);
            }
            $trickRepository->add($trick);
            return $this->redirectToRoute('app_trick_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('trick/new.html.twig', [
            'trick' => $trick,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_trick_show", methods={"GET", "POST"})
     */
    public function show(Trick $trick, MessageRepository $messageRepository, Request $request, UserRepository $userRepository): Response
    {
        $messageRepository->findByTrick($trick);
        $user = $this->getUser();

        $message = new Message();
        $message->setCreateAt(new DateTimeImmutable('now'));
        $message->setIsActive = true;
        $message->setAuthor($user);
        $message->setTrick($trick);

        if ($request->isMethod('POST')) {
//            dd($request);
            $message->setContent($request->get('content'));
            $messageRepository->add($message);
        }
        return $this->render('trick/show.html.twig', [
            'trick' => $trick,
            'user' => $user
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
            $trickRepository->add($trick);
            return $this->redirectToRoute('app_trick_index', [], Response::HTTP_SEE_OTHER);
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

        return $this->redirectToRoute('app_trick_index', [], Response::HTTP_SEE_OTHER);
    }
}
