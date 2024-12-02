class AppDetails {
  static const String appName = 'Webhere';
  static const String appVersion = '1.0.0';
  static const String appMoto = "Simplify Anything...";
  //Home page
  static const String appDescription =
      'We are an innovative technology company dedicated to delivering cutting-edge solutions that transform businesses and improve lives. '
      'With a passion for excellence and a commitment to innovation, we solve complex challenges through advanced technology and creative thinking.';
  //about page
  static const String aboutTitle = 'About Us';
  static const String aboutDescription =
      'We are a team of passionate developers with expertise in creating web and mobile applications. Our goal is to deliver high-quality, innovative solutions that meet client needs.';
  //services page
  static const String servicesTitle = 'Our Services';
  static const String servicesDescription =
      'We offer a wide range of services to help businesses and individuals achieve their goals. Our services include web development, mobile app development, UI/UX design, and more.';
  static const List<Map<String, String>> serviceItems = [
    {
      'title': 'Web Development',
      'description': 'Creating responsive and modern web applications.',
    },
    {
      'title': 'Mobile App Development',
      'description': 'Building cross-platform mobile applications.',
    },
    {
      'title': 'UI/UX Design',
      'description': 'Designing intuitive and user-friendly interfaces.',
    },
  ];

  //projects page
  static const String projectsTitle = 'Projects';
  static const String projectsDescription =
      'We have worked on a variety of projects, including e-commerce platforms, task management apps, and personal portfolios.';
  static const List<Map<String, String>> projectItems = [
    {
      'title': 'E-commerce Platform',
      'description': 'Full-stack e-commerce web application',
    },
    {
      'title': 'Task Management App',
      'description': 'Mobile app for team task tracking',
    },
    {
      'title': 'Portfolio Website',
      'description': 'Personal portfolio showcasing projects',
    },
  ];

  //contact page
  static const String contactTitle = 'Contact Us';
  static const String contactDescription =
      'If you have any questions or need assistance, please feel free to reach out to us. We are here to help!';
  static const String contactName = 'Name';
  static const String contactNameHint = 'Please enter your name';
  static const String contactEmail = 'Email';
  static const String contactEmailHint = 'Please enter your email';
  static const String contactMessage = 'Message';
  static const String contactMessageHint = 'Please enter your message';
  static const String contactSubmit = 'Submit';
}
