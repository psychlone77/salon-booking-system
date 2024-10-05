import Image from "next/image";
import {Navbar, NavbarBrand, NavbarContent, NavbarItem, Link, Button} from "@nextui-org/react";

export default function Home() {
  return (
    <div className="flex flex-col bg-tertiary items-center font-serif font-bold min-h-screen">
    <Navbar isBordered={true} shouldHideOnScroll={true}>
      <NavbarBrand>
        {/* <AcmeLogo /> */}
        <p className="font-bold text-inherit">ACME</p>
      </NavbarBrand>
      <NavbarContent className="hidden sm:flex gap-4" justify="center">
        <NavbarItem>
          <Link color="foreground" href="#">
            Features
          </Link>
        </NavbarItem>
        <NavbarItem isActive>
          <Link href="#" aria-current="page">
            Customers
          </Link>
        </NavbarItem>
        <NavbarItem>
          <Link color="foreground" href="#">
            Integrations
          </Link>
        </NavbarItem>
      </NavbarContent>
      <NavbarContent justify="end">
        <NavbarItem className="hidden lg:flex">
          <Link href="#">Login</Link>
        </NavbarItem>
        <NavbarItem>
          <Button as={Link} color="primary" href="#" variant="flat">
            Sign Up
          </Button>
        </NavbarItem>
      </NavbarContent>
    </Navbar>
      <header className="relative mb-12 w-full h-screen">
        <Image
          src="/salon-hero.jpg"
          alt="Salon Booking System Logo"
          layout="fill"
          objectFit="cover"
          className="absolute inset-0 z-0"
        />
        
        <div className="relative z-10 flex flex-col items-center justify-center h-full bg-black bg-opacity-50">
          <h1 className="sm:text-9xl font-bold mt-4 text-white">Welcome to Our Salon</h1>
          <p className="text-6xl mt-2 text-white">Book your appointment with ease</p>
        </div>
      </header>
      <main className="flex flex-col items-center gap-4">
        <a
          className="bg-blue-500 text-text py-2 px-4 rounded-full hover:bg-blue-600 transition"
          href="/book"
        >
          Book an Appointment
        </a>
        <a
          className="bg-gray-500 text-text py-2 px-4 rounded-full hover:bg-gray-600 transition"
          href="/services"
        >
          View Services
        </a>
        <a
          className="bg-green-500 text-text py-2 px-4 rounded-full hover:bg-green-600 transition"
          href="/contact"
        >
          Contact Us
        </a>
      </main>
      <footer className="mt-12 text-center">
        <p className="text-sm text-gray-600">
          &copy; 2023 Salon Booking System. All rights reserved.
        </p>
      </footer>
    </div>
  );
}
