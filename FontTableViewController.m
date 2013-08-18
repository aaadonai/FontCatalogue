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
#import "Font.h"
#import <QuartzCore/QuartzCore.h>

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
    
    [self loadCatalogue];
    
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

    
    //[self.navigationItem setLeftBarButtonItem:self.editButtonItem];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    if(editing)
    {
        DLog(@"editMode on");
    }
    else
    {
        DLog(@"Done leave editmode");
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
    DLog(@"Count: %d", [self.fontCatalogue count]);
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

        // Delete the row from the data source
        //[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
      
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    DLog(@"Row moved");
    //exchange object
    [self.fontCatalogue exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    // unset any sorting options
    menuView.sortSegmentedControl.selectedSegmentIndex = -1;
    menuView.reverseSort.on = NO;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


#pragma mark - Custom methods
- (void)openMenuPopOver:(id)sender {
//    NSSortDescriptor * sortDesc = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
//    [self.fontCatalogue sortUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
//    [self.tableView reloadData];
    

    DLog(@"X: %f",self.view.bounds.size.width - 20);
    DLog(@"Y: %f", self.view.bounds.origin.y);
    
    pv = [PopoverView showPopoverAtPoint:CGPointMake(self.view.bounds.size.width - 20, self.view.bounds.origin.y)
                                  inView:self.view
                         withContentView:menuView 
                                delegate:self]; // Show calendar with no title

    
}

- (void)loadCatalogue{
    self.fontCatalogue = [NSMutableArray arrayWithCapacity:[UIFont familyNames].count];
    for (NSString* fontName in [UIFont familyNames]) {
        Font* font = [[Font alloc]initWithName:fontName];
        [self.fontCatalogue addObject:font];
    }
    textAlignment = NSTextAlignmentLeft;
    backwards = NO;
    [menuView reset];
    [self.tableView reloadData];
}

#pragma mark - MenuViewDelegate methods

- (void)menuViewEditBtnPressed:(MenuView *)aMenuView {
    [self setEditing:YES animated:YES];
    [pv dismiss];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)menuViewRevertBtnPressed:(MenuView*)aMenuView{
    [self loadCatalogue];
    //[pv dismiss];
}

- (void)menuViewAlignBtnPressed:(MenuView*)aMenuView{
    DLog(@"Alignment Option: %d", aMenuView.alignmentSegmentedControl.selectedSegmentIndex);
    if (aMenuView.alignmentSegmentedControl.selectedSegmentIndex == kAlignmentOptionLeft) {
        textAlignment = NSTextAlignmentLeft;
    } else if(aMenuView.alignmentSegmentedControl.selectedSegmentIndex == kAlignmentOptionRight){
        textAlignment = NSTextAlignmentRight;
    }
    [self.tableView reloadData];
    //[pv dismiss];
}

- (void)menuViewBackwardsBtnPressed:(MenuView*)aMenuView{
    backwards = aMenuView.backwards.on;
    //backwards will influence alpha sorting too
    if (aMenuView.sortSegmentedControl.selectedSegmentIndex == 0) {
        [self menuViewSortBtnPressed:aMenuView];
    }
    [self.tableView reloadData];
    //[pv dismiss];
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
    [self.tableView reloadData];
    //[pv dismiss];
}

@end
