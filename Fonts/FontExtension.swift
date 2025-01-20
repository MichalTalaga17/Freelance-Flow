//
//  FontExtension.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//
import SwiftUI

extension Font {
    
    // MARK: - Font Names

    private static var regularFontName: String {
        "Roboto-Regular"
    }

    private static var mediumFontName: String {
        "Roboto-Medium"
    }

    private static var boldFontName: String {
        "Roboto-Bold"
    }

    private static var semiBoldFontName: String {
        "Roboto-SemiBold"
    }
    
    private static var extraBoldFontName: String {
           "Roboto-ExtraBold"
       }

    private static var heavyFontName: String {
        "Roboto-Black"
    }

    private static var lightFontName: String {
        "Roboto-Light"
    }

    private static var thinFontName: String {
        "Roboto-ExtraLight"
    }

    private static var ultraThinFontName: String {
        "Roboto-Thin"
    }

    // MARK: - Font Sizes (Fixed)
    private static func preferredSize(for style: TextStyle) -> CGFloat {
        switch style {
        case .largeTitle:
            return 34 // Domyślny rozmiar dla largeTitle
        case .title:
             return 28 // Domyślny rozmiar dla title
        case .title2:
            return 22 // Domyślny rozmiar dla title2
        case .title3:
             return 20 // Domyślny rozmiar dla title3
        case .headline:
             return 18 // Domyślny rozmiar dla headline
        case .subheadline:
             return 16 // Domyślny rozmiar dla subheadline
        case .body:
             return 16 // Domyślny rozmiar dla body
        case .callout:
             return 15 // Domyślny rozmiar dla callout
        case .footnote:
             return 13 // Domyślny rozmiar dla footnote
        case .caption:
             return 12 // Domyślny rozmiar dla caption
        case .caption2:
            return 11 // Domyślny rozmiar dla caption2
        default:
            return 16 // Domyślny rozmiar dla innych stylów
        }
    }

     // MARK: - Roboto Font Styles
    
    private static func robotoFont(name: String, size: CGFloat) -> Font? {
         Font.custom(name, size: size)
    }

    private static func robotoFont(for style: TextStyle, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
         let size = preferredSize(for: style)
         let fontName: String
         
         switch weight {
         case .bold:
             fontName = boldFontName
         case .regular:
            fontName = regularFontName
         case .heavy:
             fontName = heavyFontName
         case .light:
             fontName = lightFontName
         case .medium:
             fontName = mediumFontName
        case .semibold:
             fontName = semiBoldFontName
         case .thin:
            fontName = thinFontName
        case .ultraLight:
             fontName = ultraThinFontName
         default:
             fontName = regularFontName
         }
        
        if let font = robotoFont(name: fontName, size: size){
            return font
        } else {
            return .system(style, design: design)
        }
     }

    public static var largeTitle: Font { robotoFont(for: .largeTitle) }

    public static var title: Font { robotoFont(for: .title) }

    public static var title2: Font { robotoFont(for: .title2) }

    public static var title3: Font { robotoFont(for: .title3) }
    
    public static var headline: Font { robotoFont(for: .headline) }

    public static var subheadline: Font { robotoFont(for: .subheadline) }

    public static var body: Font { robotoFont(for: .body) }

    public static var callout: Font { robotoFont(for: .callout) }

    public static var footnote: Font { robotoFont(for: .footnote) }

    public static var caption: Font { robotoFont(for: .caption) }

    public static var caption2: Font { robotoFont(for: .caption2) }


     public static func system(_ style: Font.TextStyle, design: Font.Design? = nil, weight: Font.Weight? = nil) -> Font {
        if let weight = weight, let design = design {
           return robotoFont(for: style, weight: weight, design: design)
        } else if let weight = weight {
           return robotoFont(for: style, weight: weight)
        }
        else if let design = design {
           return robotoFont(for: style, design: design)
        }
        else {
           return robotoFont(for: style)
        }
    }

     public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        let fontName: String
         
         switch weight {
         case .bold:
             fontName = boldFontName
         case .regular:
            fontName = regularFontName
        case .heavy:
            fontName = heavyFontName
        case .light:
            fontName = lightFontName
         case .medium:
             fontName = mediumFontName
        case .semibold:
            fontName = semiBoldFontName
        case .thin:
           fontName = thinFontName
        case .ultraLight:
            fontName = ultraThinFontName
        default:
            fontName = regularFontName
        }
        
        if let font = robotoFont(name: fontName, size: size) {
            return font
        } else {
            return .system(size: size, weight: weight, design: design)
        }
    }
}
