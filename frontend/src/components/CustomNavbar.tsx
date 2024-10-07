"use client";

import React from "react";
import { Navbar, NavbarBrand, NavbarContent, NavbarItem, Link, Button } from "@nextui-org/react";
import { useRouter } from "next/navigation";

const CustomNavbar: React.FC = () => {
  const router = useRouter();

  return (
    <Navbar className="fixed font-serif bg-tertiary" position="static" shouldHideOnScroll={true}>
      <NavbarBrand>
        {/* <AcmeLogo /> */}
        <a href="/" className="text-3xl font-thin text-inherit">StyleSync</a>
      </NavbarBrand>
      <NavbarContent className="hidden sm:flex gap-4" justify="center">
        <NavbarItem>
          <Link color="foreground" href="#">
            Features
          </Link>
        </NavbarItem>
        <NavbarItem>
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
          <Link href="/login">Login</Link>
        </NavbarItem>
        <NavbarItem>
            <Button color="primary" onPress={() => router.push("/signup")}>
            Sign Up
            </Button>
        </NavbarItem>
      </NavbarContent>
    </Navbar>
  );
};

export default CustomNavbar;
