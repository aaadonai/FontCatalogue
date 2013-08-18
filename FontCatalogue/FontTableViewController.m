//
//  FontTableViewController.m
//  FontCatalogue
//
//  Created by Antonio Rodrigues on 12/08/13.
//  Copyright (c) 2013 Antonio Rodrigues. All rights reserved.
//

#import "FontTableViewController.h"
#import "MenuView.h"
#import "PopoverView.h"
#import "Font+CustomHelper.h"
#import <QuartzCore/QuartzCore.h>
#import "CoreDataManager.h"
#import "MenuOptionsManager.h"
#import "FontViewController.h"

@interface FontTableViewController ()<PopoverViewDelegate, MenuViewDelegate> {
    UIBarButtonItem *menuButton;
    MenuView *menuView;
}

@end

@implementation FontTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCatalogueFromCoreData];
    
    self.navigationItem.title = @"Fonts";
    
    menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenuPopOver:)];
    self.navigationItem.rightBarButtonItem = menuButton;
    
    //Create MenuView
    menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 240, 220)];
    menuView.delegate = self;
    menuView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.f]; //Give it a background color
    menuView.layer.borderColor = [UIColor colorWithWhite:0.9f alpha:1.f].CGColor; //Add a border
    menuView.layer.borderWidth = 0.5f; //One retina pixel width
    menuView.layer.cornerRadius = 4.f;
    menuView.layer.masksToBounds = YES;
    
    [self applyMenuOptions];

}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    if(!editing){
        self.navigationItem.rightBarButtonItem = menuButton;
    }
    
    [super setEditing:editing animated:animate];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.fontCatalogue count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    Font* font = [self.fontCatalogue objectAtIndex:indexPath.row];
    if (backwards){
        cell.textLabel.text = font.backwards;
    } else {
        cell.textLabel.text = font.name;
    }
    
    cell.textLabel.textAlignment = textAlignment;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Update array
        Font* font = [self.fontCatalogue objectAtIndex:indexPath.row];
        [self.fontCatalogue removeObject:font];
        [[CoreDataManager sharedManager]saveContext];
        // Delete the row from the data source
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
      
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    //exchange object
    [self.fontCatalogue exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    // unset any sorting options
    menuView.sortSegmentedControl.selectedSegmentIndex = -1;
    menuView.reverseSort.on = NO;
    [[MenuOptionsManager sharedManager]setSort:menuView.sortSegmentedControl.selectedSegmentIndex];
    [[MenuOptionsManager sharedManager]setReverse:menuView.reverseSort.on];
    [[MenuOptionsManager sharedManager]writeDocument];//save changes
    //reorder
    [self reorderFontCatalogue];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //save frequency to core data
    Font* font = self.fontCatalogue[indexPath.item];
    int i = [font.frequency intValue];
    font.frequency = [NSNumber numberWithInt:i+1];
    [[CoreDataManager sharedManager]saveContext];
    //pushing font view controller to screen
    FontViewController* fontViewController = [[FontViewController alloc] initWithFont:font];
    [self.navigationController pushViewController:fontViewController animated:YES];
}


#pragma mark - Custom methods
- (void)openMenuPopOver:(id)sender {
    
    pv = [PopoverView showPopoverAtPoint:CGPointMake(self.view.bounds.size.width - 20,
                                                     self.view.bounds.origin.y)
                                  inView:self.view
                         withContentView:menuView 
                                delegate:self]; 
    
}

- (NSArray*)fetchCatalogueFromCoreData{
    //fetches fonts from core data and order it by order
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription* entity = [NSEntityDescription entityForName:@"Font" inManagedObjectContext:[[CoreDataManager sharedManager]managedObjectContext] ];
	[fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"order" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	
	NSError* error;
	return [[[CoreDataManager sharedManager]managedObjectContext] executeFetchRequest:fetchRequest error:&error];
	

}

- (void)loadCatalogueFromCoreData{
    //load in all the fonts from core data
	NSArray* fetchedObjects = [self fetchCatalogueFromCoreData];
	self.fontCatalogue = [NSMutableArray arrayWithCapacity:[UIFont familyNames].count];
	//iterate through fetched objects and add to array
	for (Font* font in fetchedObjects) {
        [self.fontCatalogue addObject:font];
    }
    
    if (self.fontCatalogue.count <= 0){
        //if no data in core data load from UIFont
        [self loadCatalogue];
    }

}

- (void)loadCatalogue{
    //if not in core data probably is the first time it's been used
    self.fontCatalogue = [NSMutableArray arrayWithCapacity:[UIFont familyNames].count];
    for (NSString* fontName in [UIFont familyNames]) {
        Font* font = [[Font alloc]initWithName:fontName];
        [self.fontCatalogue addObject:font];
    }
    [[CoreDataManager sharedManager]saveContext];
    textAlignment = NSTextAlignmentLeft;
    backwards = NO;
    [menuView reset];
    [self.tableView reloadData];
}

- (void) cleanCatalogueFromCoreData{
    //deletes all the fonts from core data
    NSArray* fetchedObjects = [self fetchCatalogueFromCoreData];
    for (Font* font in fetchedObjects) {
        [[[CoreDataManager sharedManager]managedObjectContext] deleteObject:font];
    }
    
}

- (void)reorderFontCatalogue {
    //reorder the fonts and saves to core data
    int order = 0;
    for (Font* font in self.fontCatalogue) {
        font.order = [NSNumber numberWithInt:order++];
    }
    [[CoreDataManager sharedManager]saveContext];

}

- (void)applyMenuOptions{
    if([[MenuOptionsManager sharedManager]alignment] == 0){
        textAlignment = NSTextAlignmentLeft;
    } else {
        textAlignment = NSTextAlignmentRight;
    }
    backwards = [(MenuOptionsManager*)[MenuOptionsManager sharedManager]backwards];
}


#pragma mark - MenuViewDelegate methods

- (void)menuViewEditBtnPressed:(MenuView *)aMenuView {
    [self setEditing:YES animated:YES];
    [pv dismiss];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)menuViewRevertBtnPressed:(MenuView*)aMenuView{
    [self cleanCatalogueFromCoreData];
    [self loadCatalogue];//will load fonts from UIFont
}

- (void)menuViewAlignBtnPressed:(MenuView*)aMenuView{
    if (aMenuView.alignmentSegmentedControl.selectedSegmentIndex == kAlignmentOptionLeft) {
        textAlignment = NSTextAlignmentLeft;
    } else if(aMenuView.alignmentSegmentedControl.selectedSegmentIndex == kAlignmentOptionRight){
        textAlignment = NSTextAlignmentRight;
    }
    [self.tableView reloadData];
}

- (void)menuViewBackwardsBtnPressed:(MenuView*)aMenuView{
    backwards = aMenuView.backwards.on;
    //backwards will influence alpha sorting too
    if (aMenuView.sortSegmentedControl.selectedSegmentIndex == 0) {
        [self menuViewSortBtnPressed:aMenuView];
    }
    [self.tableView reloadData];
}

- (void)menuViewSortBtnPressed:(MenuView*)aMenuView{
    NSSortDescriptor *sort;
    switch (aMenuView.sortSegmentedControl.selectedSegmentIndex) {
        case 0:
            sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:!aMenuView.reverseSort.on];
            break;
        case 1:
            sort = [NSSortDescriptor sortDescriptorWithKey:@"characterCount" ascending:!aMenuView.reverseSort.on];
            break;
        case 2:
            sort = [NSSortDescriptor sortDescriptorWithKey:@"displaySize" ascending:!aMenuView.reverseSort.on];
            break;
        default:
            break;
    }
    [self.fontCatalogue sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    [self reorderFontCatalogue];//also saves context
    [self.tableView reloadData];
}

@end
